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
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.patrick.itdepot.R;
import com.patrick.itdepot.activity.ActMain;
import com.patrick.itdepot.adapters.AdapterQuotes;
import com.patrick.itdepot.framework.getquotes.GetQuotes;
import com.patrick.itdepot.framework.getquotes.GetQuotesRequest;
import com.patrick.itdepot.framework.getquotes.GetQuotesResponse;
import com.patrick.itdepot.helper.LocalStorage;
import com.patrick.itdepot.webapis.WebAPIClient;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by iroid on 8/24/2016.
 */
public class FragQuotes extends Fragment {

    private ListView lstQuotes;
    private ActMain root;
    private LinearLayout loadingView;
    private TextView lblNoDataQuote;

    private ArrayList<GetQuotes> arrQuotes = new ArrayList<>();
    private AdapterQuotes adapterQuotes;

    private void findViews() {
        View view = getView();
        lstQuotes = (ListView) view.findViewById(R.id.lstQuotes);
        loadingView = (LinearLayout) view.findViewById(R.id.loadingView);
        lblNoDataQuote = (TextView) view.findViewById(R.id.lblNoDataQuote);
    }


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.frag_quotes, container, false);
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

        adapterQuotes = new AdapterQuotes(getActivity(), 0, arrQuotes);
        lstQuotes.setAdapter(adapterQuotes);

        GetQuotesRequest getQuotesRequest = new GetQuotesRequest();
        if (user_id.equals("")) {
            getQuotesRequest.setUserId("-1");
        } else {
            getQuotesRequest.setUserId(user_id);
        }

        callget_quotesAPI(getQuotesRequest);
    }

    //--------------------get_quotes--------------------------------------------------------

    private void callget_quotesAPI(GetQuotesRequest getQuotesRequest) {
        loadingView.setVisibility(View.VISIBLE);
        WebAPIClient.getInstance(root).get_quotes(getQuotesRequest, new Callback<GetQuotesResponse>() {
            @Override
            public void onResponse(Call<GetQuotesResponse> call, Response<GetQuotesResponse> response) {
                loadingView.setVisibility(View.GONE);
                GetQuotesResponse getQuotesResponse = response.body();
                if (getQuotesResponse.getFlag().equals("true")) {
                    arrQuotes.clear();
                    arrQuotes.addAll(getQuotesResponse.getData());
                    adapterQuotes.notifyDataSetChanged();
                } else {
                   /* lstQuotes.setVisibility(View.GONE);
                    lblNoDataQuote.setVisibility(View.VISIBLE);
                    lblNoDataQuote.setText(getString(R.string.empty_quote));*/
                    //IRoidAppHelper.showAlert(root,getQuotesResponse.get);
                    if (getQuotesResponse.getCode() == 99) {
                        showRegisterAlert(getString(R.string.user_not_found));
                    } else {

                    }
                }
            }

            @Override
            public void onFailure(Call<GetQuotesResponse> call, Throwable t) {
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
}
