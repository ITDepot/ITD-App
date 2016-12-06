package com.patrick.itdepot.fragments;

import android.app.Activity;
import android.app.Dialog;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import com.patrick.itdepot.R;
import com.patrick.itdepot.activity.ActMain;
import com.patrick.itdepot.framework.register.RegisterRequest;
import com.patrick.itdepot.framework.register.RegisterResponse;
import com.patrick.itdepot.framework.updateagent.UpdateAgentRequest;
import com.patrick.itdepot.framework.updateagent.UpdateAgentResponse;
import com.patrick.itdepot.helper.IRoidAppHelper;
import com.patrick.itdepot.helper.LocalStorage;
import com.patrick.itdepot.webapis.WebAPIClient;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by iroid on 9/20/2016.
 */
public class FragRegister extends Fragment implements View.OnClickListener {

    private ActMain root;
    private LinearLayout loadingView;

    private LinearLayout llDetailReg;
    private EditText txtFname;
    private EditText txtLname;
    private EditText txtEmailRegister;
    private EditText txtPhoneRegister;
    private EditText txtCmpName;
    private EditText txtStreet;
    private EditText txtSuit;
    private EditText txtCity;
    private EditText txtStateReg;
    private EditText txtZip;
    private RelativeLayout relSave;

    private String action;

    public void setAction(String action) {
        this.action = action;
    }

    private void findViews() {
        View view = getView();
        txtFname = (EditText) view.findViewById(R.id.txtFname);
        txtLname = (EditText) view.findViewById(R.id.txtLname);
        txtEmailRegister = (EditText) view.findViewById(R.id.txtEmailRegister);
        txtPhoneRegister = (EditText) view.findViewById(R.id.txtPhoneRegister);
        txtCmpName = (EditText) view.findViewById(R.id.txtCmpName);
        txtStreet = (EditText) view.findViewById(R.id.txtStreet);
        txtSuit = (EditText) view.findViewById(R.id.txtSuit);
        txtCity = (EditText) view.findViewById(R.id.txtCity);
        txtStateReg = (EditText) view.findViewById(R.id.txtStateReg);
        txtZip = (EditText) view.findViewById(R.id.txtZip);
        relSave = (RelativeLayout) view.findViewById(R.id.relSave);
        loadingView = (LinearLayout) view.findViewById(R.id.loadingView);
        llDetailReg = (LinearLayout) view.findViewById(R.id.llDetailReg);

        relSave.setOnClickListener(this);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.frag_register, container, false);
    }

    @Override
    public void onStart() {
        super.onStart();
        root.setMenuTitle(getString(R.string.back_page));
        root.setServiceButton(View.GONE);
        root.setMenuImage(getResources().getDrawable(R.drawable.back));
        findViews();
        fillData();
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
        if (v == relSave) {
            if (action.equals(getString(R.string.add))) {
                validateForm();
            } else {
                editData();
            }
        }
    }

    private void fillData() {
        if (action.equals(getString(R.string.add))) {

        } else {
            setData();
        }
    }

    private void validateForm() {
        llDetailReg.setVisibility(View.VISIBLE);
        String first_name = txtFname.getText().toString().trim();
        String last_name = txtLname.getText().toString().trim();
        String email = txtEmailRegister.getText().toString().trim();
        String phone_number = txtPhoneRegister.getText().toString().trim();
        String cmp = txtCmpName.getText().toString().trim();
        String street = txtStreet.getText().toString().trim();
        String suite = txtSuit.getText().toString().trim();
        String city = txtCity.getText().toString().trim();
        String state = txtStateReg.getText().toString().trim();
        String zip = txtZip.getText().toString().trim();

        //-------------------------------------
        if (first_name.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_fname));
            return;
        } else {
            txtFname.setError(null);
        }
        //-------------------------------------
        if (last_name.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_lname));
            return;
        } else {
            txtLname.setError(null);
        }
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
        //-------------------------------------
        if (phone_number.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_pnub));
            return;
        } else {
            txtPhoneRegister.setError(null);
        }
        /*//-------------------------------------
        if (street.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_street_));
            return;
        } else {
            txtStreet.setError(null);
        }
        //-------------------------------------
        if (suite.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_suit));
            return;
        } else {
            txtSuit.setError(null);
        }
        //-------------------------------------
        if (city.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_city_));
            return;
        } else {
            txtCity.setError(null);
        }
        //-------------------------------------
        if (state.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_state_));
            return;
        } else {
            txtStateReg.setError(null);
        }
        //-------------------------------------
        if (zip.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_zip_));
            return;
        } else {
            txtZip.setError(null);
        }
        //-------------------------------------*/

        RegisterRequest registerRequest = new RegisterRequest();
        registerRequest.setFirstname(first_name);
        registerRequest.setLastname(last_name);
        registerRequest.setEmailId(email);
        registerRequest.setPhone(phone_number);
        /*registerRequest.setCompany(cmp);
        registerRequest.setStreet(street);
        registerRequest.setSuite(suite);
        registerRequest.setCity(city);
        registerRequest.setState(state);
        registerRequest.setZip(zip);*/
        if (IRoidAppHelper.isNetworkAvailable(getActivity())) {
            callregistrationAPI(registerRequest);
        } else {
            IRoidAppHelper.showAlert(getActivity(), getString(R.string.net_not_avilable));
        }
        //-------------------------------------


    }

    private void setData() {
        llDetailReg.setVisibility(View.GONE);
        txtCmpName.setVisibility(View.VISIBLE);
        txtStreet.setVisibility(View.VISIBLE);
        txtSuit.setVisibility(View.VISIBLE);
        txtCity.setVisibility(View.VISIBLE);
        txtStateReg.setVisibility(View.VISIBLE);
        txtZip.setVisibility(View.VISIBLE);

        LocalStorage localStorage = new LocalStorage(getActivity());
        String firstname = localStorage.GetItem(LocalStorage.firstname);
        String lastname = localStorage.GetItem(LocalStorage.lastname);
        String email_id = localStorage.GetItem(LocalStorage.email_id);
        String phone = localStorage.GetItem(LocalStorage.phone);
        String company = localStorage.GetItem(LocalStorage.company);
        String street = localStorage.GetItem(LocalStorage.street);
        String suite = localStorage.GetItem(LocalStorage.suite);
        String city = localStorage.GetItem(LocalStorage.city);
        String state = localStorage.GetItem(LocalStorage.state);
        String zip = localStorage.GetItem(LocalStorage.zip);

        try {
            txtFname.setText(firstname);
            txtLname.setText(lastname);
            txtEmailRegister.setText(email_id);
            txtPhoneRegister.setText(phone);
            txtCmpName.setText(company);
            txtStreet.setText(street);
            txtSuit.setText(suite);
            txtCity.setText(city);
            txtStateReg.setText(state);
            txtZip.setText(zip);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void editData() {
        String first_name = txtFname.getText().toString().trim();
        String last_name = txtLname.getText().toString().trim();
        String email = txtEmailRegister.getText().toString().trim();
        String phone_number = txtPhoneRegister.getText().toString().trim();
        String cmp = txtCmpName.getText().toString().trim();
        String street = txtStreet.getText().toString().trim();
        String suite = txtSuit.getText().toString().trim();
        String city = txtCity.getText().toString().trim();
        String state = txtStateReg.getText().toString().trim();
        String zip = txtZip.getText().toString().trim();

        //-------------------------------------
        if (first_name.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_fname));
            return;
        } else {
            txtFname.setError(null);
        }
        //-------------------------------------
        if (last_name.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_lname));
            return;
        } else {
            txtLname.setError(null);
        }
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
        //-------------------------------------
        if (phone_number.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_pnub));
            return;
        } else {
            txtPhoneRegister.setError(null);
        }
        /*//-------------------------------------
        if (street.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_street_));
            return;
        } else {
            txtStreet.setError(null);
        }
        //-------------------------------------
        if (suite.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_suit));
            return;
        } else {
            txtSuit.setError(null);
        }
        //-------------------------------------
        if (city.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_city_));
            return;
        } else {
            txtCity.setError(null);
        }
        //-------------------------------------
        if (state.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_state_));
            return;
        } else {
            txtStateReg.setError(null);
        }
        //-------------------------------------
        if (zip.equals("")) {
            IRoidAppHelper.showAlert(root, getString(R.string.empty_zip_));
            return;
        } else {
            txtZip.setError(null);
        }
        //-------------------------------------*/

        LocalStorage localStorage = new LocalStorage(getActivity());
        String user_id = localStorage.GetItem(LocalStorage.user_id);
        UpdateAgentRequest updateAgentRequest = new UpdateAgentRequest();

        updateAgentRequest.setUser_id(user_id);
        updateAgentRequest.setFirstname(first_name);
        updateAgentRequest.setLastname(last_name);
        updateAgentRequest.setEmailId(email);
        updateAgentRequest.setPhone(phone_number);
        updateAgentRequest.setCompany(cmp);
        updateAgentRequest.setStreet(street);
        updateAgentRequest.setSuite(suite);
        updateAgentRequest.setCity(city);
        updateAgentRequest.setState(state);
        updateAgentRequest.setZip(zip);
        callupdate_agentAPI(updateAgentRequest);
        //-------------------------------------
    }

    //---------------------------registration-------------------------------------------------

    private void callregistrationAPI(RegisterRequest registerRequest) {
        loadingView.setVisibility(View.VISIBLE);
        WebAPIClient.getInstance(root).registration(registerRequest, new Callback<RegisterResponse>() {
            @Override
            public void onResponse(Call<RegisterResponse> call, Response<RegisterResponse> response) {
                loadingView.setVisibility(View.GONE);
                RegisterResponse registerResponse = response.body();
                if (registerResponse.getFlag().equals("true")) {
                    String user_id = registerResponse.getData().getUserId();
                    String firstname = registerResponse.getData().getFirstname();
                    String lastname = registerResponse.getData().getLastname();
                    String email_id = registerResponse.getData().getEmailId();
                    String phone = registerResponse.getData().getPhone();
                    String company = registerResponse.getData().getCompany();
                    String street = registerResponse.getData().getStreet();
                    String suite = registerResponse.getData().getSuite();
                    String city = registerResponse.getData().getCity();
                    String state = registerResponse.getData().getState();
                    String zip = registerResponse.getData().getZip();
                    String created_at = registerResponse.getData().getCreatedAt();
                    String updated_at = registerResponse.getData().getUpdatedAt();

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

                    //gotoActivityReport();
                    Log.e("register", "Success");
                    showConfirmDialog();

                } else {
                    IRoidAppHelper.showAlert(root, registerResponse.getMsg());
                    Log.e("register", "Error");
                }
            }

            @Override
            public void onFailure(Call<RegisterResponse> call, Throwable t) {
                loadingView.setVisibility(View.GONE);
                Log.e("register", "Fail");
            }
        });

    }

    //---------------------------update_agent-------------------------------------------------

    private void callupdate_agentAPI(UpdateAgentRequest updateAgentRequest) {

        loadingView.setVisibility(View.VISIBLE);
        WebAPIClient.getInstance(root).update_agent(updateAgentRequest, new Callback<UpdateAgentResponse>() {
            @Override
            public void onResponse(Call<UpdateAgentResponse> call, Response<UpdateAgentResponse> response) {
                loadingView.setVisibility(View.GONE);
                UpdateAgentResponse updateAgentResponse = response.body();
                if (updateAgentResponse.getFlag().equals("true")) {
                    String user_id = updateAgentResponse.getData().getUserId();
                    String firstname = updateAgentResponse.getData().getFirstname();
                    String lastname = updateAgentResponse.getData().getLastname();
                    String email_id = updateAgentResponse.getData().getEmailId();
                    String phone = updateAgentResponse.getData().getPhone();
                    String company = updateAgentResponse.getData().getCompany();
                    String street = updateAgentResponse.getData().getStreet();
                    String suite = updateAgentResponse.getData().getSuite();
                    String city = updateAgentResponse.getData().getCity();
                    String state = updateAgentResponse.getData().getState();
                    String zip = updateAgentResponse.getData().getZip();
                    String created_at = updateAgentResponse.getData().getCreatedAt();
                    String updated_at = updateAgentResponse.getData().getUpdatedAt();

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

                    getActivity().getSupportFragmentManager().popBackStack();
                } else {
                    //IRoidAppHelper.showAlert(root, "Update Profile Successfully.");
                }
            }

            @Override
            public void onFailure(Call<UpdateAgentResponse> call, Throwable t) {
                loadingView.setVisibility(View.GONE);
            }
        });
    }

    //------------------------------------------------------------------------------------------
    private void showConfirmDialog() {

        RelativeLayout btnContinueReg;

        final Dialog dialog = new Dialog(getActivity());
        final View popView = LayoutInflater.from(getActivity()).inflate(R.layout.pop_confirm_register, null);
        btnContinueReg = (RelativeLayout) popView.findViewById(R.id.btnContinueReg);

        btnContinueReg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
                getActivity().getSupportFragmentManager().popBackStack();
            }
        });

        dialog.setCancelable(false);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dialog.setContentView(popView);
        dialog.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
        dialog.getWindow().setLayout(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        dialog.show();
    }

    //------------------------------------------------------------------------------------------
    private void gotoActivityReport() {
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragActivityReport fragActivityReport = new FragActivityReport();
        fragmentTransaction.add(R.id.fragContainer, fragActivityReport, FragActivityReport.class.getName());
        fragmentTransaction.commit();
    }

    //------------------------------------------------------------------------------------------
}
