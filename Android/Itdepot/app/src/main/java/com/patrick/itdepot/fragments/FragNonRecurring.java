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
import com.patrick.itdepot.adapters.AdapterNonRecurring;
import com.patrick.itdepot.framework.getnonrecurring.GetNonRecurring;
import com.patrick.itdepot.framework.getnonrecurring.GetNonRecurringRequest;
import com.patrick.itdepot.framework.getnonrecurring.GetNonRecurringResponse;
import com.patrick.itdepot.helper.LocalStorage;
import com.patrick.itdepot.webapis.WebAPIClient;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by iroid on 8/24/2016.
 */
public class FragNonRecurring extends Fragment {
    private ActMain root;
    private ArrayList<GetNonRecurring> arrNonRecurring = new ArrayList<>();
    private AdapterNonRecurring adapterNonRecurring;
    private GetNonRecurring arrTotalNonRecurring;
    private LinearLayout loadingView;

    private ListView lstNonReccuring;
    private LinearLayout loFooter;
    private TextView lblTotalNrIncome, lblNoDataNI;

    private void findViews() {
        View view = getView();
        lstNonReccuring = (ListView) view.findViewById(R.id.lstNonReccuring);
        loadingView = (LinearLayout) view.findViewById(R.id.loadingView);
        lblNoDataNI = (TextView) view.findViewById(R.id.lblNoDataNI);

        //code to set adapter to populate list
        View footerView = ((LayoutInflater) getActivity().getSystemService(Context.LAYOUT_INFLATER_SERVICE)).inflate(R.layout.footer_non_recurring, null, false);
        lstNonReccuring.addFooterView(footerView);
        lblTotalNrIncome = (TextView) footerView.findViewById(R.id.lblTotalNrIncome);
    }


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.frag_non_reccuring_income, container, false);
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
        String agent_uniq_id = localStorage.GetItem(LocalStorage.agent_uniq_id);

        adapterNonRecurring = new AdapterNonRecurring(getActivity(), 0, arrNonRecurring);
        lstNonReccuring.setAdapter(adapterNonRecurring);

        GetNonRecurringRequest getNonRecurringRequest = new GetNonRecurringRequest();
        if (user_id.equals("")) {
            getNonRecurringRequest.setUserId("-1");
        } else {
            getNonRecurringRequest.setUserId(user_id);
        }
        callget_non_recurring_incomeAPI(getNonRecurringRequest);
    }
    //--------------------get_non_recurring_income--------------------------------------------------

    private void callget_non_recurring_incomeAPI(GetNonRecurringRequest getNonRecurringRequest) {
        loadingView.setVisibility(View.VISIBLE);
        WebAPIClient.getInstance(root).get_non_recurring_income(getNonRecurringRequest, new Callback<GetNonRecurringResponse>() {
            @Override
            public void onResponse(Call<GetNonRecurringResponse> call, Response<GetNonRecurringResponse> response) {
                loadingView.setVisibility(View.GONE);
                GetNonRecurringResponse getNonRecurringResponse = response.body();
                if (getNonRecurringResponse.getFlag().equals("true")) {
                    arrNonRecurring.clear();
                    arrNonRecurring.addAll(getNonRecurringResponse.getData());

                    //----------remove last data from list-----------------------------
                    arrTotalNonRecurring = arrNonRecurring.get(arrNonRecurring.size() - 1);
                    arrNonRecurring.remove(arrNonRecurring.size() - 1);
                    lblTotalNrIncome.setText(arrTotalNonRecurring.getNrIncomeTotal());
                    String this_month_income = arrTotalNonRecurring.getNrIncomeTotal();
                    LocalStorage localStorage = new LocalStorage(getActivity());
                    localStorage.PutItem(LocalStorage.this_month_income, this_month_income);
                    Log.e("this_month_income", this_month_income);
                    //-----------------------------------------------------------------
                    adapterNonRecurring.notifyDataSetChanged();
                } else {
                    if (getNonRecurringResponse.getCode() == 99) {
                        showRegisterAlert(getString(R.string.user_not_found));
                    } else {

                    }
                   /* lstNonReccuring.setVisibility(View.GONE);
                    lblNoDataNI.setVisibility(View.VISIBLE);
                    lblNoDataNI.setText(getString(R.string.empty_nr));*/
                }
            }

            @Override
            public void onFailure(Call<GetNonRecurringResponse> call, Throwable t) {
                loadingView.setVisibility(View.GONE);
            }
        });
    }

    //----------------------------------------------------------------------------------------------
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
}
