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
import com.patrick.itdepot.adapters.AdapterInstallPendding;
import com.patrick.itdepot.framework.getinstallpendding.GetInstallPenddingRequest;
import com.patrick.itdepot.framework.getinstallpendding.GetInstallPenddingResponse;
import com.patrick.itdepot.framework.getinstallpendding.GetinstallPendding;
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
public class FragInstallPending extends Fragment {

    private ActMain root;
    private LinearLayout loadingView;

    private ArrayList<GetinstallPendding> arrInstallPending = new ArrayList<>();
    private AdapterInstallPendding adapterInstallPendding;
    private GetinstallPendding totalInstall;


    private ListView lstIstallPending;
    private LinearLayout loFooter;
    private TextView lblTotalNr;
    private TextView lblTotalMr;
    private TextView lblNoDataIP;

    private void findViews() {
        View view = getView();
        lstIstallPending = (ListView) view.findViewById(R.id.lstIstallPending);
        loadingView = (LinearLayout) view.findViewById(R.id.loadingView);
        lblNoDataIP = (TextView) view.findViewById(R.id.lblNoDataIP);

        //code to set adapter to populate list
        View footerView = ((LayoutInflater) getActivity().getSystemService(Context.LAYOUT_INFLATER_SERVICE)).inflate(R.layout.footer_install_pending, null, false);
        lblTotalNr = (TextView) footerView.findViewById(R.id.lblTotalNr);
        lblTotalMr = (TextView) footerView.findViewById(R.id.lblTotalMr);
        lstIstallPending.addFooterView(footerView);

    }


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.frag_install_pending, container, false);
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

        adapterInstallPendding = new AdapterInstallPendding(getActivity(), 0, arrInstallPending);
        lstIstallPending.setAdapter(adapterInstallPendding);

        GetInstallPenddingRequest getInstallPenddingRequest = new GetInstallPenddingRequest();
        if (user_id.equals("")) {
            getInstallPenddingRequest.setUserId("-1");
        } else {

            getInstallPenddingRequest.setUserId(user_id);
        }
        callget_install_penddingAPI(getInstallPenddingRequest);


    }
    //--------------------get_install_pendding--------------------------------------------------------

    private void callget_install_penddingAPI(GetInstallPenddingRequest getInstallPenddingRequest) {
        loadingView.setVisibility(View.VISIBLE);
        WebAPIClient.getInstance(root).get_install_pendding(getInstallPenddingRequest, new Callback<GetInstallPenddingResponse>() {
            @Override
            public void onResponse(Call<GetInstallPenddingResponse> call, Response<GetInstallPenddingResponse> response) {
                loadingView.setVisibility(View.GONE);
                GetInstallPenddingResponse getInstallPenddingResponse = response.body();
                if (getInstallPenddingResponse.getFlag().equals("true")) {

                    arrInstallPending.clear();
                    arrInstallPending.addAll(getInstallPenddingResponse.getData());

                    //----------remove last data from list-----------------------------
                    totalInstall = arrInstallPending.get(arrInstallPending.size() - 1);
                    arrInstallPending.remove(arrInstallPending.size() - 1);
                    lblTotalNr.setText(totalInstall.getNrIncomeTotal());
                    lblTotalMr.setText(totalInstall.getMrIncomeTotal());
                    //-----------------------------------------------------------------
                    adapterInstallPendding.notifyDataSetChanged();

                } else {

                    if (getInstallPenddingResponse.getCode() == 99){
                        showRegisterAlert(getString(R.string.user_not_found));
                    }else {

                    }
                  /*  lstIstallPending.setVisibility(View.GONE);
                    lblNoDataIP.setVisibility(View.VISIBLE);
                    lblNoDataIP.setText(getInstallPenddingResponse.getMsg());*/
                }
            }

            @Override
            public void onFailure(Call<GetInstallPenddingResponse> call, Throwable t) {
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
