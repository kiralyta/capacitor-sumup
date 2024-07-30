package hu.rahop.plugins.sumup;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

import com.sumup.merchant.reader.api.SumUpAPI;
import com.sumup.merchant.reader.api.SumUpLogin;
import com.sumup.merchant.reader.api.SumUpPayment;

@CapacitorPlugin(name = "SumUp")
public class SumUpPlugin extends Plugin {

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
}
