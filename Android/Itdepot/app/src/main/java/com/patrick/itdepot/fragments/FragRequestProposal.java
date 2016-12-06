package com.patrick.itdepot.fragments;

import android.app.Activity;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.widget.CardView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.patrick.itdepot.R;
import com.patrick.itdepot.activity.ActMain;
import com.patrick.itdepot.helper.LocalStorage;

/**
 * Created by iroid on 8/24/2016.
 */
public class FragRequestProposal extends Fragment implements View.OnClickListener {

    private TextView lblMonthlyIncome;
    private CardView cardInternet;
    private LinearLayout llInternet;
    private TextView lblInternet;
    private LinearLayout llPhoneServices;
    private TextView lblThisMonth;
    private LinearLayout llCabling, llIncome, llAct;

    private RelativeLayout relMonthlyIncome, relAct;
    private ImageView imgInternet, imgPhoneService, imgCabling;
    protected static final String EXTRA_SERVICES = "EXTRA_SERVICES";
    private ActMain root;

    public static final String TYPE_INTERNET = "Internet";
    public static final String TYPE_PHONE_SERVICE = "Phone Service";
    public static final String TYPE_CABLING = "Cabling";

    private void findViews() {
        View view = getView();
        lblMonthlyIncome = (TextView) view.findViewById(R.id.lblMonthlyIncome);
        cardInternet = (CardView) view.findViewById(R.id.cardInternet);
        llInternet = (LinearLayout) view.findViewById(R.id.llInternet);
        lblInternet = (TextView) view.findViewById(R.id.lblInternet);
        llPhoneServices = (LinearLayout) view.findViewById(R.id.llPhoneServices);
        llCabling = (LinearLayout) view.findViewById(R.id.llCabling);
        relMonthlyIncome = (RelativeLayout) view.findViewById(R.id.relMonthlyIncome);
        imgInternet = (ImageView) view.findViewById(R.id.imgInternet);
        imgPhoneService = (ImageView) view.findViewById(R.id.imgPhoneService);
        imgCabling = (ImageView) view.findViewById(R.id.imgCabling);
        llIncome = (LinearLayout) view.findViewById(R.id.llIncome);
        llAct = (LinearLayout) view.findViewById(R.id.llAct);
        relAct = (RelativeLayout) view.findViewById(R.id.relAct);
        lblMonthlyIncome= (TextView) view.findViewById(R.id.lblMonthlyIncome);
        lblThisMonth= (TextView) view.findViewById(R.id.lblThisMonth);

        imgInternet.setOnClickListener(this);
        relMonthlyIncome.setOnClickListener(this);
        imgPhoneService.setOnClickListener(this);
        imgCabling.setOnClickListener(this);
        relAct.setOnClickListener(this);
    }


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.frag_request_proposal, container, false);
    }

    @Override
    public void onStart() {
        super.onStart();
        findViews();
        fillData();
        root.setMenuTitle(getString(R.string.account_page));
        root.setServiceButton(View.GONE);
        root.setMenuImage(getResources().getDrawable(R.drawable.account_user));
    }

    private void fillData() {

        LocalStorage localStorage = new LocalStorage(getActivity());
        String this_month_income = localStorage.GetItem(LocalStorage.this_month_income);
        String monthly_reccuring = localStorage.GetItem(LocalStorage.monthly_reccuring);
        String user_id = localStorage.GetItem(LocalStorage.user_id);

        if (user_id.equals("")){
            lblThisMonth.setText("$0.00");
            lblMonthlyIncome.setText("$0.00");
        }else {
            lblThisMonth.setText(this_month_income);
            lblMonthlyIncome.setText(monthly_reccuring);
        }


        llIncome.setVisibility(View.VISIBLE);
        /*
        LocalStorage localStorage = new LocalStorage(getActivity());
        String user_id = localStorage.GetItem(LocalStorage.user_id);
        if (user_id.equals("")) {
            llIncome.setVisibility(View.VISIBLE);
            llAct.setVisibility(View.GONE);
        } else {
            llIncome.setVisibility(View.GONE);
            llAct.setVisibility(View.VISIBLE);
        }*/

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
        if (v == imgInternet) {
            gotoTechno(TYPE_INTERNET);
        } else if (v == imgPhoneService) {
            gotoTechno(TYPE_PHONE_SERVICE);
        } else if (v == imgCabling) {
            gotoTechno(TYPE_CABLING);
        } else if (v == relAct) {
            gotoActivityReport();
        }
    }

    //----------------------------------------------------------------------------------------------
    private void gotoInternet(String Internet_service) {
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragInternet fragDummy = new FragInternet();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        Bundle bundle = new Bundle();
        bundle.putString(EXTRA_SERVICES, Internet_service);
        fragDummy.setArguments(bundle);
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragInternet.class.getName());
        fragmentTransaction.addToBackStack(FragInternet.class.getName());
        fragmentTransaction.commit();
    }

    //----------------------------------------------------------------------------------------------
    private void gotoPhoneService(String phone_service) {
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragPhoneService fragDummy = new FragPhoneService();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        Bundle bundle = new Bundle();
        bundle.putString(EXTRA_SERVICES, phone_service);
        fragDummy.setArguments(bundle);
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragPhoneService.class.getName());
        fragmentTransaction.addToBackStack(FragPhoneService.class.getName());
        fragmentTransaction.commit();
    }

    //----------------------------------------------------------------------------------------------
    private void gotoCabling(String cabling_service) {
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragCabling fragDummy = new FragCabling();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        Bundle bundle = new Bundle();
        bundle.putString(EXTRA_SERVICES, cabling_service);
        fragDummy.setArguments(bundle);
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragCabling.class.getName());
        fragmentTransaction.addToBackStack(FragCabling.class.getName());
        fragmentTransaction.commit();
    }

    //----------------------------------------------------------------------------------------------


    private void gotoTechno(String type) {
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragResources fragDummy = new FragResources();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        Bundle bundle = new Bundle();
        bundle.putString(EXTRA_SERVICES, type);
        fragDummy.setArguments(bundle);
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragResources.class.getName());
        fragmentTransaction.addToBackStack(FragResources.class.getName());
        fragmentTransaction.commit();
    }

    //----------------------------------------------------------------------------------------------
    private void gotoActivityReport() {
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragActivityReport fragDummy = new FragActivityReport();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragActivityReport.class.getName());
        fragmentTransaction.addToBackStack(FragActivityReport.class.getName());
        fragmentTransaction.commit();
    }


    //----------------------------------------------------------------------------------------------
}
