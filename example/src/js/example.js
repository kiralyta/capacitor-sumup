import { SumUp } from 'capacitor-sumup';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    SumUp.echo({ value: inputValue })
}
