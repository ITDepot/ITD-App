package com.patrick.itdepot.activity;

import android.app.Dialog;
import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.patrick.itdepot.R;
import com.patrick.itdepot.fragments.FragActivityReport;
import com.patrick.itdepot.fragments.FragRegister;
import com.patrick.itdepot.fragments.FragRequestProposal;
import com.patrick.itdepot.fragments.FragYourAccount;
import com.patrick.itdepot.framework.isuservalid.IsUserValidRequest;
import com.patrick.itdepot.framework.isuservalid.IsUserValidResponse;
import com.patrick.itdepot.framework.loginagent.LoginAgentRequest;
import com.patrick.itdepot.framework.loginagent.LoginAgentResponse;
import com.patrick.itdepot.helper.IRoidAppHelper;
import com.patrick.itdepot.helper.LocalStorage;
import com.patrick.itdepot.webapis.WebAPIClient;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import uk.co.chrisjenx.calligraphy.CalligraphyContextWrapper;


public class ActMain extends AppCompatActivity implements View.OnClickListener {

    private RelativeLayout relAccount;
    private ImageView imgAccount;
    private TextView lblAccount;
    private FrameLayout fragContainer;
    private LinearLayout llMain;
    private RelativeLayout relService;
    private ImageView imgLogo;
    Dialog dialog;


    private void findViews() {
        relAccount = (RelativeLayout) findViewById(R.id.relAccount);
        relService = (RelativeLayout) findViewById(R.id.relService);
        imgAccount = (ImageView) findViewById(R.id.imgAccount);
        lblAccount = (TextView) findViewById(R.id.lblAccount);
        fragContainer = (FrameLayout) findViewById(R.id.fragContainer);
        llMain = (LinearLayout) findViewById(R.id.llMain);
        imgLogo = (ImageView) findViewById(R.id.imgLogo);
        relAccount.setOnClickListener(this);
        relService.setOnClickListener(this);
        imgLogo.setOnClickListener(this);

        try {
            LocalStorage localStorage = new LocalStorage(getApplicationContext());
            String user_id = localStorage.GetItem(LocalStorage.user_id);
            IsUserValidRequest isUserValidRequest = new IsUserValidRequest();
            isUserValidRequest.setUserId(user_id);
            callis_user_validAPI(isUserValidRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.act_main);
        findViews();
        /*if (new LocalStorage(this).GetItem(LocalStorage.IS_LOGIN_FIRST_TIME).equals("")) {
            showLoginDailog();
        }*/

        FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
        FragRequestProposal fragDummy = new FragRequestProposal();
        fragmentTransaction.add(R.id.fragContainer, fragDummy, FragRequestProposal.class.getName());
        fragmentTransaction.commit();
    }

    public void setServiceButton(int visibility) {
        relService.setVisibility(visibility);
    }

    private void fillData() {
        if (lblAccount.getText().equals("Account")) {

            LocalStorage localStorage = new LocalStorage(getApplicationContext());
            String user_id = localStorage.GetItem(LocalStorage.user_id);
            if (user_id.equals("")) {
                showRegisterAlert();
            } else {
                // gotoYourAccount();
                gotoActivityReport();
            }
        } else {
            onBackPressed();
        }

    }

    private void clickActButton() {
        LocalStorage localStorage = new LocalStorage(getApplicationContext());
        String user_id = localStorage.GetItem(LocalStorage.user_id);
        if (user_id.equals("")) {
            showRegisterAlert();
        } else {
            gotoActivityReport();
        }
    }

    @Override
    public void onClick(View v) {
        if (v == relAccount) {
            fillData();
        } else if (v == relService) {
            // ClearFragments();
            clickActButton();
        } else if (v == imgLogo) {
            ClearFragments();
        }
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
    }

    //-------------------set Menu Title-----------------------------------
    public void setMenuTitle(String msg) {
        lblAccount.setText(msg);
    }

    //---------------set Menu Image----------------------------------------
    public void setMenuImage(Drawable img) {
        imgAccount.setImageDrawable(img);
    }

    //-------------ShowLoginDailog----------------------------------------

    private void showLoginDailog() {
        final EditText txtUniqueId;
        Button btnOk;

        dialog = new Dialog(this);
        final View popView = LayoutInflater.from(this).inflate(R.layout.pre_login_dailog, null);
        txtUniqueId = (EditText) popView.findViewById(R.id.txtUniqueId);
        btnOk = (Button) popView.findViewById(R.id.btnOk);


        btnOk.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                final String unique_id = txtUniqueId.getText().toString().trim();
                if (unique_id.equals("")) {
                    IRoidAppHelper.showAlert(ActMain.this, getString(R.string.empty_unique_id));
                    return;
                } else {
                    LoginAgentRequest loginAgentRequest = new LoginAgentRequest();
                    loginAgentRequest.setAgentUniqId(unique_id);
                    calllogin_agentAPI(loginAgentRequest);

                }
            }
        });

        dialog.setCancelable(false);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dialog.setContentView(popView);
        dialog.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
        dialog.getWindow().setLayout(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        dialog.show();
    }

    //-------------------------------login_agent--------------------------------------------------

    private void calllogin_agentAPI(LoginAgentRequest loginAgentRequest) {
        WebAPIClient.getInstance(ActMain.this).login_agent(loginAgentRequest, new Callback<LoginAgentResponse>() {
            @Override
            public void onResponse(Call<LoginAgentResponse> call, Response<LoginAgentResponse> response) {
                LoginAgentResponse loginAgentResponse = response.body();
                if (loginAgentResponse.getFlag().equals("true")) {

                    String agent_id = loginAgentResponse.getData().getAgentId();
                    String agent_uniq_id = loginAgentResponse.getData().getAgentUniqId();
                    String agent_name = loginAgentResponse.getData().getAgentName();
                    String status = loginAgentResponse.getData().getStatus();
                    String created_at = loginAgentResponse.getData().getCreatedAt();
                    String updated_at = loginAgentResponse.getData().getUpdatedAt();

                    LocalStorage localStorage = new LocalStorage(ActMain.this);
                    localStorage.PutItem(LocalStorage.agent_id, agent_id);
                    localStorage.PutItem(LocalStorage.agent_uniq_id, agent_uniq_id);
                    localStorage.PutItem(LocalStorage.agent_name, agent_name);
                    localStorage.PutItem(LocalStorage.status, status);
                    localStorage.PutItem(LocalStorage.created_at, created_at);
                    localStorage.PutItem(LocalStorage.updated_at, updated_at);

                    localStorage.PutItem(LocalStorage.IS_LOGIN_FIRST_TIME, "1");
                    dialog.dismiss();
                } else {
                    IRoidAppHelper.showAlert(ActMain.this, loginAgentResponse.getMsg());
                }
            }

            @Override
            public void onFailure(Call<LoginAgentResponse> call, Throwable t) {
                IRoidAppHelper.showAlert(ActMain.this, t.getMessage());
            }
        });
    }


    //----------------------------------------------------------------------------------------------
    private void gotoYourAccount() {

        FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
        FragYourAccount fragDummy = new FragYourAccount();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragYourAccount.class.getName());
        fragmentTransaction.addToBackStack(FragYourAccount.class.getName());
        fragmentTransaction.commit();
    }

    //----------------------------------------------------------------------------------------------
    private void gotoActivityReport() {

        FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
        FragActivityReport fragDummy = new FragActivityReport();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragActivityReport.class.getName());
        fragmentTransaction.addToBackStack(FragActivityReport.class.getName());
        fragmentTransaction.commit();
    }
    //-------------calligraphy-----------

    @Override
    protected void attachBaseContext(Context newBase) {
        super.attachBaseContext(CalligraphyContextWrapper.wrap(newBase));
    }

    //------------------------------------------------------------

    public void ClearFragments() {
        FragmentManager fm = getSupportFragmentManager();
        for (int i = 0; i < fm.getBackStackEntryCount(); ++i) {
            fm.popBackStack();
        }
    }
    //-------------------------------------showRegisterAlert----------------------------------------

    private void showRegisterAlert() {

        RelativeLayout btnCancel, btnContinue;

        dialog = new Dialog(this);
        final View popView = LayoutInflater.from(this).inflate(R.layout.pop_register_alert, null);
        btnCancel = (RelativeLayout) popView.findViewById(R.id.btnCancel);
        btnContinue = (RelativeLayout) popView.findViewById(R.id.btnContinue);

        btnContinue.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                gotoRegister();
                dialog.dismiss();
            }
        });

        btnCancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });

        dialog.setCancelable(false);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dialog.setContentView(popView);
        dialog.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
        dialog.getWindow().setLayout(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        dialog.show();
    }

    //----------------------------------------------------------------------------------------------
    private void gotoRegister() {
        FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
        FragRegister fragDummy = new FragRegister();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        fragDummy.setAction(getString(R.string.add));
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragRegister.class.getName());
        fragmentTransaction.addToBackStack(FragRegister.class.getName());
        fragmentTransaction.commit();
    }

    //----------------------------------------------------------------------------------------------
    private void callis_user_validAPI(IsUserValidRequest isUserValidRequest) {
        WebAPIClient.getInstance(this).is_user_valid(isUserValidRequest, new Callback<IsUserValidResponse>() {
            @Override
            public void onResponse(Call<IsUserValidResponse> call, Response<IsUserValidResponse> response) {
                IsUserValidResponse isUserValidResponse = response.body();
                if (isUserValidResponse.getFlag().equals("true")) {

                } else {
                    LocalStorage localStorage = new LocalStorage(getApplicationContext());
                    localStorage.Clear();
                }
            }

            @Override
            public void onFailure(Call<IsUserValidResponse> call, Throwable t) {

            }
        });

    }
    //----------------------------------------------------------------------------------------------
    //----------------------------------------------------------------------------------------------
}
