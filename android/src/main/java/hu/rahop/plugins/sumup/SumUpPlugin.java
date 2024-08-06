package hu.rahop.plugins.sumup;

import android.app.Activity;

import java.math.BigDecimal;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

import com.sumup.merchant.reader.api.SumUpAPI;
import com.sumup.merchant.reader.api.SumUpLogin;
import com.sumup.merchant.reader.api.SumUpPayment;
import com.sumup.merchant.reader.api.SumUpState;

@CapacitorPlugin(name = "SumUp")
public class SumUpPlugin extends Plugin {

     @Override
     public void load() {
         SumUpState.init(getContext());
     }

    @PluginMethod
    public void login(PluginCall call) {
        if (!call.getData().has("affiliateKey")) {
            call.reject("Must provide an affiliateKey");
            return;
        }

        if (!call.getData().has("accessToken")) {
            call.reject("Must provide an accessToken");
            return;
        }

        String affiliateKey = call.getString("affiliateKey");
        String accessToken = call.getString("accessToken");

        SumUpLogin sumupLogin = SumUpLogin
            .builder(affiliateKey)
            .accessToken(accessToken)
            .build();

        SumUpAPI.openLoginActivity(
            getActivity(),
            sumupLogin,
            1
        );

        call.resolve();
    }

    @PluginMethod
    public void checkout(PluginCall call) {
        if (!call.getData().has("amount")) {
            call.reject("Must provide amount");
            return;
        }

        Double amount = call.getDouble("amount");
        if (amount == null || amount <= 0) {
            call.reject("Invalid amount");
            return;
        }

        // Default values
        boolean skipSuccessScreen = true;
        SumUpPayment.Currency currency = SumUpPayment.Currency.HUF;
        String foreignTransactionId = null;
        BigDecimal tip = BigDecimal.ZERO;

        // Check for additional parameters and set values accordingly
        if (call.getData().has("skipReceiptScreen")) {
            skipSuccessScreen = call.getBoolean("skipReceiptScreen", false);
        }

        if (call.getData().has("currency")) {
            String currencyStr = call.getString("currency");
            try {
                currency = SumUpPayment.Currency.valueOf(currencyStr);
            } catch (IllegalArgumentException e) {
                call.reject("Invalid currency");
                return;
            }
        }

        if (call.getData().has("foreignTransactionID")) {
            foreignTransactionId = call.getString("foreignTransactionID");
            if (foreignTransactionId != null && foreignTransactionId.length() > 128) {
                call.reject("foreignTransactionID cannot exceed 128 characters");
                return;
            }
        }

        if (call.getData().has("tipAmount")) {
            Double tipAmount = call.getDouble("tipAmount");
            if (tipAmount != null && tipAmount > 0) {
                tip = BigDecimal.valueOf(tipAmount);
            }
        }

        SumUpPayment.Builder paymentBuilder = SumUpPayment.builder()
                .total(BigDecimal.valueOf(amount))
                .currency(currency)
                .title("Time to Pay");

        if (skipSuccessScreen) {
            paymentBuilder.skipSuccessScreen();
        }

        if (foreignTransactionId != null) {
            paymentBuilder.foreignTransactionId(foreignTransactionId);
        }

        if (tip.compareTo(BigDecimal.ZERO) > 0) {
            paymentBuilder.tip(tip);
        }

        SumUpPayment payment = paymentBuilder.build();

        Activity activity = getActivity(); // Get the Activity context

        if (activity != null) {
            SumUpAPI.checkout(activity, payment, 2); // Use the Activity context
            call.resolve();
        } else {
            call.reject("Activity context is null");
        }

        call.resolve();
    }

    @PluginMethod
    public void wakeUp(PluginCall call) {
        call.unimplemented("Not implemented on Android. (SumUp Android SDK is buggy)");
        //  SumUpAPI.prepareForCheckout();

        //  call.resolve();
    }

    @PluginMethod
    public void logout(PluginCall call) {
        SumUpAPI.logout();

        call.resolve();
    }
}
