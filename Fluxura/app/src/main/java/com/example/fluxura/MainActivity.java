package com.example.fluxura;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.text.Html;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    TextView EqnText, IniTime;
    Button button0, button1, button2, button3, button4, button5, button6,
            button7, button8, button9, buttonAdd, buttonSub, buttonDivision,
            buttonMul, button10, buttonC, buttonEqual;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        EqnText = (TextView) findViewById(R.id.EquationText);
        EqnText.setText(Html.fromHtml("f<sup><small>(4)</small></sup> = af<sup><small>(3)</small></sup> + bf<sup><small>(2)</small></sup> + cf<sup><small>(1)</small></sup> + df<sup><small>(0)</small></sup> + e"));
    }
}