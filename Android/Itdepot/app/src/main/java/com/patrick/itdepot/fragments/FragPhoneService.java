package com.patrick.itdepot.fragments;

import android.app.Activity;
import android.app.Dialog;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.patrick.itdepot.R;
import com.patrick.itdepot.activity.ActMain;
import com.patrick.itdepot.framework.isuservalid.IsUserValidRequest;
import com.patrick.itdepot.framework.isuservalid.IsUserValidResponse;
import com.patrick.itdepot.helper.LocalStorage;
import com.patrick.itdepot.webapis.WebAPIClient;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by iroid on 9/19/2016.
 */
public class FragPhoneService extends Fragment implements View.OnClickListener {

    private ActMain root;

    private RelativeLayout relPhoneContMe;
    private RelativeLayout relPhoneContClient;
    private TextView lblPhoneIncome;
    private Dialog dialog;


    private void findViews() {
        View view = getView();
        relPhoneContMe = (RelativeLayout) view.findViewById(R.id.relPhoneContMe);
        lblPhoneIncome = (TextView) view.findViewById(R.id.lblPhoneIncome);
        relPhoneContClient = (RelativeLayout) view.findViewById(R.id.relPhoneContClient);
        relPhoneContMe.setOnClickListener(this);
        relPhoneContClient.setOnClickListener(this);

    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.frag_phone_services, container, false);
    }

    @Override
    public void onStart() {
        super.onStart();
        root.setMenuTitle(getString(R.string.back_page));
        root.setServiceButton(View.VISIBLE);
        root.setMenuImage(getResources().getDrawable(R.drawable.back));
        findViews();
        checkUser();
    }

    public FragPhoneService newInstance(String Phone_Service) {
        FragPhoneService f = new FragPhoneService();
        Bundle b = new Bundle();
        b.putString(FragRequestProposal.EXTRA_SERVICES, Phone_Service);
        f.setArguments(b);
        return f;
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
        String service_name = getArguments().getString(FragRequestProposal.EXTRA_SERVICES);
        LocalStorage localStorage = new LocalStorage(getActivity());
        String user_id = localStorage.GetItem(LocalStorage.user_id);
        if (v == relPhoneContMe) {
            checkUser();
            if (user_id.equals("")) {
                showRegisterAlert();
            } else {
                gotoCallMe(service_name);
            }
        } else if (v == relPhoneContClient) {
            checkUser();
            if (user_id.equals("")) {
                showRegisterAlert();
            } else {
                gotoContactClient(service_name);
            }
        }
    }
    private void checkUser(){

        LocalStorage localStorage = new LocalStorage(getActivity());
        String user_id = localStorage.GetItem(LocalStorage.user_id);

        IsUserValidRequest isUserValidRequest = new IsUserValidRequest();
        isUserValidRequest.setUserId(user_id);
        callis_user_validAPI(isUserValidRequest);

    }
    //-------------------------------------showRegisterAlert----------------------------------------

    private void showRegisterAlert() {

        RelativeLayout btnCancel,btnContinue;

        dialog = new Dialog(getActivity());
        final View popView = LayoutInflater.from(getActivity()).inflate(R.layout.pop_register_alert, null);
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
    private void gotoCallMe(String call_phone) {
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragContactMe fragDummy = new FragContactMe();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        Bundle bundle = new Bundle();
        bundle.putString(FragRequestProposal.EXTRA_SERVICES, call_phone);
        // bundle.putString("phone", call_phone);
        fragDummy.setArguments(bundle);
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragContactMe.class.getName());
        fragmentTransaction.addToBackStack(FragContactMe.class.getName());
        fragmentTransaction.commit();
    }

    //----------------------------------------------------------------------------------------------
    private void gotoContactClient(String phone_client) {
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragContactClient fragDummy = new FragContactClient();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        Bundle bundle = new Bundle();
        bundle.putString(FragRequestProposal.EXTRA_SERVICES, phone_client);
        fragDummy.setArguments(bundle);
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragContactClient.class.getName());
        fragmentTransaction.addToBackStack(FragContactClient.class.getName());
        fragmentTransaction.commit();
    }

    //----------------------------------------------------------------------------------------------
    private void gotoRegister() {
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragRegister fragDummy = new FragRegister();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        fragDummy.setAction(getString(R.string.add));
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragRegister.class.getName());
        fragmentTransaction.addToBackStack(FragRegister.class.getName());
        fragmentTransaction.commit();
    }
    //----------------------------------------------------------------------------------------------
    private void callis_user_validAPI(IsUserValidRequest isUserValidRequest) {
        WebAPIClient.getInstance(root).is_user_valid(isUserValidRequest, new Callback<IsUserValidResponse>() {
            @Override
            public void onResponse(Call<IsUserValidResponse> call, Response<IsUserValidResponse> response) {
                IsUserValidResponse isUserValidResponse = response.body();
                if (isUserValidResponse.getFlag().equals("true")) {

                } else {
                    LocalStorage localStorage = new LocalStorage(getActivity());
                    localStorage.Clear();
                }
            }

            @Override
            public void onFailure(Call<IsUserValidResponse> call, Throwable t) {

            }
        });

    }
    //----------------------------------------------------------------------------------------------
}
