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

import com.patrick.itdepot.R;
import com.patrick.itdepot.activity.ActMain;
import com.patrick.itdepot.helper.LocalStorage;

/**
 * Created by iroid on 9/19/2016.
 */
public class FragCabling extends Fragment implements View.OnClickListener {

    private ActMain root;
    private RelativeLayout relContMeCable;
    private RelativeLayout relContClientCable;
    private Dialog dialog;


    private void findViews() {
        View view = getView();
        relContMeCable = (RelativeLayout) view.findViewById(R.id.relContMeCable);
        relContClientCable = (RelativeLayout) view.findViewById(R.id.relContClientCable);
        relContMeCable.setOnClickListener(this);
        relContClientCable.setOnClickListener(this);
    }


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.frag_cabling, container, false);
    }

    @Override
    public void onStart() {
        super.onStart();
        root.setMenuTitle(getString(R.string.back_page));
        root.setServiceButton(View.VISIBLE);
        root.setMenuImage(getResources().getDrawable(R.drawable.back));
        findViews();
    }

    public FragCabling newInstance(String Cabling) {
        FragCabling f = new FragCabling();
        Bundle b = new Bundle();
        b.putString(FragRequestProposal.EXTRA_SERVICES, Cabling);
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
        if (v == relContMeCable) {
            if (user_id.equals("")) {
                showRegisterAlert();
            } else {
                gotoCallMe(service_name);
            }
        } else if (v == relContClientCable) {
            if (user_id.equals("")) {
                showRegisterAlert();
            } else {
                gotoContactClient(service_name);
            }
        }
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

    //----------------------------------------------------------------------------------------------
    private void gotoCallMe(String cable_call) {
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragContactMe fragDummy = new FragContactMe();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        Bundle bundle = new Bundle();
        bundle.putString(FragRequestProposal.EXTRA_SERVICES, cable_call);
        fragDummy.setArguments(bundle);
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragContactMe.class.getName());
        fragmentTransaction.addToBackStack(FragContactMe.class.getName());
        fragmentTransaction.commit();
    }

    //----------------------------------------------------------------------------------------------
    private void gotoContactClient(String cable_client) {
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragContactClient fragDummy = new FragContactClient();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        Bundle bundle = new Bundle();
        bundle.putString(FragRequestProposal.EXTRA_SERVICES, cable_client);
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
    //----------------------------------------------------------------------------------------------
}
