package com.patrick.itdepot.fragments;

import android.app.Activity;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import com.patrick.itdepot.R;
import com.patrick.itdepot.activity.ActMain;
import com.patrick.itdepot.framework.login.LoginRequest;
import com.patrick.itdepot.framework.login.LoginResponse;
import com.patrick.itdepot.helper.IRoidAppHelper;
import com.patrick.itdepot.helper.LocalStorage;
import com.patrick.itdepot.webapis.WebAPIClient;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by iroid on 9/20/2016.
 */
public class FragLogin extends Fragment implements View.OnClickListener {

    private ActMain root;
    private LinearLayout loadingView;

    private EditText txtEmailLogin;
    private EditText txtPhoneLogin;
    private RelativeLayout relLogin;

    private void findViews() {
        View view = getView();
        txtEmailLogin = (EditText) view.findViewById(R.id.txtEmailLogin);
        txtPhoneLogin = (EditText) view.findViewById(R.id.txtPhoneLogin);
        relLogin = (RelativeLayout) view.findViewById(R.id.relLogin);

        loadingView = (LinearLayout) view.findViewById(R.id.loadingView);
        relLogin.setOnClickListener(this);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.frag_login, container, false);
    }

    @Override
    public void onStart() {
        super.onStart();
        root.setMenuTitle(getString(R.string.back_page));
        root.setServiceButton(View.GONE);
        root.setMenuImage(getResources().getDrawable(R.drawable.back));
        findViews();
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        root = (ActMain) activity;
    }

    @Override
    public void onStop() {
        super.onStop();
    }

    @Override
    public void onClick(View v) {
        if (v == relLogin) {
            validateForm();
        }
    }

    private void validateForm() {
        String email = txtEmailLogin.getText().toString().trim();
        String phone_nub = txtPhoneLogin.getText().toString().trim();
        //-------------------------------------
        if (email.equals("")) {
            IRoidAppHelper.showAlert(getActivity(), getString(R.string.enterEmail));
            return;
        } else {
            if (IRoidAppHelper.IsValidEmailAddress(email) == false) {
                IRoidAppHelper.showAlert(getActivity(), getString(R.string.invalidEmail));
                return;
            }
        }
        //---------------------------------------
        if (phone_nub.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_pnub));
            return;
        } else {
            txtPhoneLogin.setError(null);
        }
        //---------------------------------------
        LoginRequest loginRequest = new LoginRequest();
        loginRequest.setEmailId(email);
        loginRequest.setPhone(phone_nub);
        callloginAPI(loginRequest);
        //---------------------------------------
    }

    //---------------------------login-------------------------------------------------

    private void callloginAPI(LoginRequest loginRequest) {
        loadingView.setVisibility(View.VISIBLE);
        WebAPIClient.getInstance(root).login(loginRequest, new Callback<LoginResponse>() {
            @Override
            public void onResponse(Call<LoginResponse> call, Response<LoginResponse> response) {
                loadingView.setVisibility(View.GONE);
                LoginResponse loginResponse = response.body();
                if (loginResponse.getFlag().equals("true")) {
                    String user_id = loginResponse.getData().getUserId();
                    String firstname = loginResponse.getData().getFirstname();
                    String lastname = loginResponse.getData().getLastname();
                    String email_id = loginResponse.getData().getEmailId();
                    String phone = loginResponse.getData().getPhone();
                    String company = loginResponse.getData().getCompany();
                    String street = loginResponse.getData().getStreet();
                    String suite = loginResponse.getData().getSuite();
                    String city = loginResponse.getData().getCity();
                    String state = loginResponse.getData().getState();
                    String zip = loginResponse.getData().getZip();
                    String created_at = loginResponse.getData().getCreatedAt();
                    String updated_at = loginResponse.getData().getUpdatedAt();

                    LocalStorage localStorage = new LocalStorage(root);
                    localStorage.PutItem(LocalStorage.user_id, user_id);
                    localStorage.PutItem(LocalStorage.firstname, firstname);
                    localStorage.PutItem(LocalStorage.lastname, lastname);
                    localStorage.PutItem(LocalStorage.email_id, email_id);
                    localStorage.PutItem(LocalStorage.phone, phone);
                    localStorage.PutItem(LocalStorage.company, company);
                    localStorage.PutItem(LocalStorage.street, street);
                    localStorage.PutItem(LocalStorage.suite, suite);
                    localStorage.PutItem(LocalStorage.city, city);
                    localStorage.PutItem(LocalStorage.state, state);
                    localStorage.PutItem(LocalStorage.zip, zip);
                    localStorage.PutItem(LocalStorage.created_at, created_at);
                    localStorage.PutItem(LocalStorage.updated_at, updated_at);

                    gotoActivityReport();
                } else {
                    IRoidAppHelper.showAlert(getActivity(), getString(R.string.wrong_login));
                }
            }

            @Override
            public void onFailure(Call<LoginResponse> call, Throwable t) {
                loadingView.setVisibility(View.GONE);
            }
        });
    }

    //----------------------------------------------------------------------------------------------
    private void gotoActivityReport() {
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragActivityReport fragActivityReport = new FragActivityReport();
        fragmentTransaction.add(R.id.fragContainer, fragActivityReport, FragActivityReport.class.getName());
        fragmentTransaction.commit();
    }
    //----------------------------------------------------------------------------------------------

}
