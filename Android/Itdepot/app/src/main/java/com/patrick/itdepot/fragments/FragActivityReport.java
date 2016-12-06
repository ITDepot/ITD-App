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
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

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
 * Created by iroid on 11/11/2016.
 */
public class FragActivityReport extends Fragment implements View.OnClickListener {

    private TextView lblFnameAct;
    private TextView lblEmailAct;
    private TextView lblPhoneAct;
    private LinearLayout llEdit;
    private RelativeLayout relEdit;
    private LinearLayout llQuote;
    private View viewQuote;
    private LinearLayout llInstallpending;
    private View viewPending;
    private LinearLayout llNrIncome;
    private View viewNrIncome;
    private LinearLayout llMrIncome;
    private View viewMrIncome;
    private FrameLayout fragContainerActivity;
    private LinearLayout loadingView;
    private ActMain root;

    private void findViews() {

        View view = getView();
        lblFnameAct = (TextView) view.findViewById(R.id.lblFnameAct);
        lblEmailAct = (TextView) view.findViewById(R.id.lblEmailAct);
        lblPhoneAct = (TextView) view.findViewById(R.id.lblPhoneAct);
        llEdit = (LinearLayout) view.findViewById(R.id.llEdit);
        relEdit = (RelativeLayout) view.findViewById(R.id.relEdit);
        llQuote = (LinearLayout) view.findViewById(R.id.llQuote);
        viewQuote = (View) view.findViewById(R.id.viewQuote);
        llInstallpending = (LinearLayout) view.findViewById(R.id.llInstallpending);
        viewPending = (View) view.findViewById(R.id.viewPending);
        llNrIncome = (LinearLayout) view.findViewById(R.id.llNrIncome);
        viewNrIncome = (View) view.findViewById(R.id.viewNrIncome);
        llMrIncome = (LinearLayout) view.findViewById(R.id.llMrIncome);
        viewMrIncome = (View) view.findViewById(R.id.viewMrIncome);
        fragContainerActivity = (FrameLayout) view.findViewById(R.id.fragContainerActivity);
        loadingView = (LinearLayout) view.findViewById(R.id.loadingView);

        llQuote.setOnClickListener(this);
        llInstallpending.setOnClickListener(this);
        llNrIncome.setOnClickListener(this);
        llMrIncome.setOnClickListener(this);
        llEdit.setOnClickListener(this);
        relEdit.setOnClickListener(this);


    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.frag_activity_report_2, container, false);
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

    private void fillData() {
        LocalStorage localStorage = new LocalStorage(getActivity());
        String fname = localStorage.GetItem(LocalStorage.firstname);
        String email = localStorage.GetItem(LocalStorage.email_id);
        String phone_nub = localStorage.GetItem(LocalStorage.phone);

        lblFnameAct.setText(fname);
        lblEmailAct.setText(email);
        lblPhoneAct.setText(phone_nub);

    }

    @Override
    public void onClick(View v) {
        LocalStorage localStorage = new LocalStorage(getActivity());
        String user_id = localStorage.GetItem(LocalStorage.user_id);

        if (v == llQuote) {

            IsUserValidRequest isUserValidRequest = new IsUserValidRequest();
            isUserValidRequest.setUserId(user_id);
            callis_user_validAPI(isUserValidRequest);

            llQuote.setBackgroundResource(R.drawable.textview_activity);
            llInstallpending.setBackgroundResource(R.drawable.textview_gray);
            llNrIncome.setBackgroundResource(R.drawable.textview_gray);
            llMrIncome.setBackgroundResource(R.drawable.textview_gray);
            viewQuote.setBackgroundResource(R.drawable.view_activity);
            viewPending.setBackgroundResource(R.drawable.view_gray);
            viewNrIncome.setBackgroundResource(R.drawable.view_gray);
            viewMrIncome.setBackgroundResource(R.drawable.view_gray);

            getChildFragmentManager().beginTransaction().replace(R.id.fragContainerActivity, new FragQuotes()).commit();
        } else if (v == llInstallpending) {

            IsUserValidRequest isUserValidRequest = new IsUserValidRequest();
            isUserValidRequest.setUserId(user_id);
            callis_user_validAPI(isUserValidRequest);

            llQuote.setBackgroundResource(R.drawable.textview_gray);
            llInstallpending.setBackgroundResource(R.drawable.textview_activity);
            llNrIncome.setBackgroundResource(R.drawable.textview_gray);
            llMrIncome.setBackgroundResource(R.drawable.textview_gray);
            viewQuote.setBackgroundResource(R.drawable.view_gray);
            viewPending.setBackgroundResource(R.drawable.view_activity);
            viewNrIncome.setBackgroundResource(R.drawable.view_gray);
            viewMrIncome.setBackgroundResource(R.drawable.view_gray);

            getChildFragmentManager().beginTransaction().replace(R.id.fragContainerActivity, new FragInstallPending()).commit();
        } else if (v == llNrIncome) {

            IsUserValidRequest isUserValidRequest = new IsUserValidRequest();
            isUserValidRequest.setUserId(user_id);
            callis_user_validAPI(isUserValidRequest);

            llQuote.setBackgroundResource(R.drawable.textview_gray);
            llInstallpending.setBackgroundResource(R.drawable.textview_gray);
            llNrIncome.setBackgroundResource(R.drawable.textview_activity);
            llMrIncome.setBackgroundResource(R.drawable.textview_gray);
            viewQuote.setBackgroundResource(R.drawable.view_gray);
            viewPending.setBackgroundResource(R.drawable.view_gray);
            viewNrIncome.setBackgroundResource(R.drawable.view_activity);
            viewMrIncome.setBackgroundResource(R.drawable.view_gray);

            getChildFragmentManager().beginTransaction().replace(R.id.fragContainerActivity, new FragNonRecurring()).commit();
        } else if (v == llMrIncome) {

            IsUserValidRequest isUserValidRequest = new IsUserValidRequest();
            isUserValidRequest.setUserId(user_id);
            callis_user_validAPI(isUserValidRequest);

            llQuote.setBackgroundResource(R.drawable.textview_gray);
            llInstallpending.setBackgroundResource(R.drawable.textview_gray);
            llNrIncome.setBackgroundResource(R.drawable.textview_gray);
            llMrIncome.setBackgroundResource(R.drawable.textview_activity);
            viewQuote.setBackgroundResource(R.drawable.view_gray);
            viewPending.setBackgroundResource(R.drawable.view_gray);
            viewNrIncome.setBackgroundResource(R.drawable.view_gray);
            viewMrIncome.setBackgroundResource(R.drawable.view_activity);

            getChildFragmentManager().beginTransaction().replace(R.id.fragContainerActivity, new FragMonthlyRecurring()).commit();
        } else if (v == llEdit || v == relEdit) {
            gotoRegister();
        }
    }

    //----------------------------------------------------------------------------------------------
    private void gotoRegister() {
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragRegister fragDummy = new FragRegister();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        fragDummy.setAction(getString(R.string.edit_));
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
