package com.patrick.itdepot.fragments;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
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
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.patrick.itdepot.R;
import com.patrick.itdepot.activity.ActMain;
import com.patrick.itdepot.adapters.AdapterMonthlyRecurring;
import com.patrick.itdepot.framework.getmonthlyrecurring.GetMonthlyRecurring;
import com.patrick.itdepot.framework.getmonthlyrecurring.GetMonthlyRecurringRequest;
import com.patrick.itdepot.framework.getmonthlyrecurring.GetMonthlyRecurringResponse;
import com.patrick.itdepot.helper.IRoidAppHelper;
import com.patrick.itdepot.helper.LocalStorage;
import com.patrick.itdepot.webapis.WebAPIClient;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by iroid on 8/24/2016.
 */
public class FragMonthlyRecurring extends Fragment {

    private ActMain root;
    private LinearLayout loadingView;

    private ArrayList<GetMonthlyRecurring> arrMonthlyIncome = new ArrayList<>();
    private AdapterMonthlyRecurring adapterMonthlyRecurring;
    private GetMonthlyRecurring arrTotalMonthly;

    private ListView lstMonthlyReccuring;
    private LinearLayout loFooter;
    private TextView lblTotalMrIncome, lblNoDataMI;

    private void findViews() {
        View view = getView();
        lstMonthlyReccuring = (ListView) view.findViewById(R.id.lstMonthlyReccuring);
        loadingView = (LinearLayout) view.findViewById(R.id.loadingView);
        lblNoDataMI = (TextView) view.findViewById(R.id.lblNoDataMI);

        //code to set adapter to populate list
        View footerView = ((LayoutInflater) getActivity().getSystemService(Context.LAYOUT_INFLATER_SERVICE)).inflate(R.layout.footer_monthly_recurring, null, false);
        lblTotalMrIncome = (TextView) footerView.findViewById(R.id.lblTotalMrIncome);
        lstMonthlyReccuring.addFooterView(footerView);

    }


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.frag_monthly_reccuring_income, container, false);
    }

    @Override
    public void onStart() {
        super.onStart();
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
        String user_id = localStorage.GetItem(LocalStorage.user_id);

        adapterMonthlyRecurring = new AdapterMonthlyRecurring(getActivity(), 0, arrMonthlyIncome);
        lstMonthlyReccuring.setAdapter(adapterMonthlyRecurring);


        GetMonthlyRecurringRequest getMonthlyRecurringRequest = new GetMonthlyRecurringRequest();
        if (user_id.equals("")) {
            getMonthlyRecurringRequest.setUserId("-1");
        } else {

            getMonthlyRecurringRequest.setUserId(user_id);
        }
        callget_monthly_recurring_incomeAPI(getMonthlyRecurringRequest);
    }


    //--------------------get_monthly_recurring_income----------------------------------------------
    private void callget_monthly_recurring_incomeAPI(GetMonthlyRecurringRequest getMonthlyRecurringRequest) {
        loadingView.setVisibility(View.VISIBLE);
        WebAPIClient.getInstance(root).get_monthly_recurring_income(getMonthlyRecurringRequest, new Callback<GetMonthlyRecurringResponse>() {
            @Override
            public void onResponse(Call<GetMonthlyRecurringResponse> call, Response<GetMonthlyRecurringResponse> response) {
                loadingView.setVisibility(View.GONE);
                GetMonthlyRecurringResponse getMonthlyRecurringResponse = response.body();
                if (getMonthlyRecurringResponse.getFlag().equals("true")) {
                    arrMonthlyIncome.clear();
                    arrMonthlyIncome.addAll(getMonthlyRecurringResponse.getData());
                    //----------remove last data from list-----------------------------
                    arrTotalMonthly = arrMonthlyIncome.get(arrMonthlyIncome.size() - 1);
                    arrMonthlyIncome.remove(arrMonthlyIncome.size() - 1);
                    lblTotalMrIncome.setText(arrTotalMonthly.getMrIncomeTotal());
                    String monthly_reccuring = arrTotalMonthly.getMrIncomeTotal();
                    LocalStorage localStorage = new LocalStorage(getActivity());
                    localStorage.PutItem(LocalStorage.monthly_reccuring, monthly_reccuring);
                    Log.e("this_month_income", monthly_reccuring);
                    //------------------------------------------------------------------

                    adapterMonthlyRecurring.notifyDataSetChanged();
                } else {
                    if (getMonthlyRecurringResponse.getCode() == 99) {
                        showRegisterAlert(getString(R.string.user_not_found));
                    } else {

                    }
                   /* lstMonthlyReccuring.setVisibility(View.GONE);
                    lblNoDataMI.setVisibility(View.VISIBLE);
                    lblNoDataMI.setText(getMonthlyRecurringResponse.getMsg());*/
                }
            }

            @Override
            public void onFailure(Call<GetMonthlyRecurringResponse> call, Throwable t) {
                loadingView.setVisibility(View.GONE);
            }
        });

    }

    private void showRegisterAlert(String msg) {

        RelativeLayout btnCancel, btnContinue;
        TextView lblMsg;

        final Dialog dialog = new Dialog(getActivity());
        final View popView = LayoutInflater.from(getActivity()).inflate(R.layout.pop_register_alert, null);
        btnCancel = (RelativeLayout) popView.findViewById(R.id.btnCancel);
        btnContinue = (RelativeLayout) popView.findViewById(R.id.btnContinue);
        lblMsg = (TextView) popView.findViewById(R.id.lblMsg);

        lblMsg.setText(msg);
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
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragRegister fragDummy = new FragRegister();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        fragDummy.setAction(getString(R.string.add));
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragRegister.class.getName());
        fragmentTransaction.addToBackStack(FragRegister.class.getName());
        fragmentTransaction.commit();
    }
    //----------------------------------------------------------------------------------------------
    //----------------------------------------------------------------------------------------------
}
