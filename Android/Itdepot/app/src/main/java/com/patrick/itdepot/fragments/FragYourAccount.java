package com.patrick.itdepot.fragments;

import android.app.Activity;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;

import com.patrick.itdepot.R;
import com.patrick.itdepot.activity.ActMain;

/**
 * Created by iroid on 9/14/2016.
 */
public class FragYourAccount extends Fragment implements View.OnClickListener {

    private ActMain root;
    private LinearLayout llLogin;
    private LinearLayout llRegister;
    private LinearLayout llActivityReport;

    private void findViews() {
        View view = getView();
        llLogin = (LinearLayout) view.findViewById(R.id.llLogin);
        llRegister = (LinearLayout) view.findViewById(R.id.llRegister);
        llActivityReport = (LinearLayout) view.findViewById(R.id.llActivityReport);

        llLogin.setOnClickListener(this);
        llRegister.setOnClickListener(this);
        llActivityReport.setOnClickListener(this);
    }


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.frag_your_account, container, false);
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
        if (v == llLogin) {
            gotoLogin();
        } else if (v == llRegister) {
            gotoRegister();
        } else if (v == llActivityReport) {
            gotoActivityReport();
        }
    }

    //----------------------------------------------------------------------------------------------
    private void gotoActivityReport() {
        ClearFragments();
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragActivityReport fragDummy = new FragActivityReport();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragActivityReport.class.getName());
        fragmentTransaction.addToBackStack(FragActivityReport.class.getName());
        fragmentTransaction.commit();
    }

    //----------------------------------------------------------------------------------------------
    private void gotoLogin() {
        ClearFragments();
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragLogin fragDummy = new FragLogin();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragLogin.class.getName());
        fragmentTransaction.addToBackStack(FragLogin.class.getName());
        fragmentTransaction.commit();
    }

    //----------------------------------------------------------------------------------------------
    private void gotoRegister() {
        ClearFragments();
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragRegister fragDummy = new FragRegister();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragRegister.class.getName());
        fragmentTransaction.addToBackStack(FragRegister.class.getName());
        fragmentTransaction.commit();
    }

    //----------------------------------------------------------------------------------------------
    public void ClearFragments() {
        FragmentManager fm = getActivity().getSupportFragmentManager();
        for (int i = 0; i < fm.getBackStackEntryCount(); ++i) {
            fm.popBackStack();
        }
    }
    //----------------------------------------------------------------------------------------------
}
