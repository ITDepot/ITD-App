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
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.patrick.itdepot.R;
import com.patrick.itdepot.activity.ActMain;
import com.patrick.itdepot.framework.callme.CallMeRequest;
import com.patrick.itdepot.framework.callme.CallMeResponse;
import com.patrick.itdepot.helper.IRoidAppHelper;
import com.patrick.itdepot.helper.LocalStorage;
import com.patrick.itdepot.webapis.WebAPIClient;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by iroid on 9/19/2016.
 */
public class FragContactMe extends Fragment implements View.OnClickListener {

    private ActMain root;
    private LinearLayout loadingView;

    private ImageView ChkInternetMe;
    private ImageView chkPhoneMe;
    private ImageView chkCableMe;
    private ImageView chkCellNub;
    private EditText txtCellNumber;
    private ImageView chkEmail;
    private EditText txtEmail;
    private EditText txtMsg;
    private RelativeLayout relContactMe;
    private ImageView imgMeInternet, imgMePhone, imgMeCable;
    private TextView lblContacted;

    private String name_of_service;

    private void findViews() {
        View view = getView();
        ChkInternetMe = (ImageView) view.findViewById(R.id.ChkInternetMe);
        chkPhoneMe = (ImageView) view.findViewById(R.id.chkPhoneMe);
        chkCableMe = (ImageView) view.findViewById(R.id.chkCableMe);
        chkCellNub = (ImageView) view.findViewById(R.id.chkCellNub);
        txtCellNumber = (EditText) view.findViewById(R.id.txtCellNumber);
        chkEmail = (ImageView) view.findViewById(R.id.chkEmail);
        txtEmail = (EditText) view.findViewById(R.id.txtEmail);
        txtMsg = (EditText) view.findViewById(R.id.txtMsg);
        relContactMe = (RelativeLayout) view.findViewById(R.id.relContactMe);
        loadingView = (LinearLayout) view.findViewById(R.id.loadingView);
        imgMeInternet = (ImageView) view.findViewById(R.id.imgMeInternet);
        imgMePhone = (ImageView) view.findViewById(R.id.imgMePhone);
        imgMeCable = (ImageView) view.findViewById(R.id.imgMeCable);
        lblContacted = (TextView) view.findViewById(R.id.lblContacted);

        relContactMe.setOnClickListener(this);
        ChkInternetMe.setOnClickListener(this);
        chkPhoneMe.setOnClickListener(this);
        chkCableMe.setOnClickListener(this);
        chkCellNub.setOnClickListener(this);
        chkEmail.setOnClickListener(this);
        imgMeInternet.setOnClickListener(this);
        imgMePhone.setOnClickListener(this);
        imgMeCable.setOnClickListener(this);

        LocalStorage localStorage = new LocalStorage(getActivity());
        String phone = localStorage.GetItem(LocalStorage.phone);
        String email = localStorage.GetItem(LocalStorage.email_id);

        txtCellNumber.setText(phone);
        txtEmail.setText(email);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.frag_contact_me, container, false);
    }

    @Override
    public void onStart() {
        super.onStart();
        findViews();
        root.setServiceButton(View.VISIBLE);
        fillCheckBox();
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
        if (v == relContactMe) {
            validateForm();
        } else if (v == ChkInternetMe || v == imgMeInternet) {

            if (ChkInternetMe.getTag().equals("0")) {
                ChkInternetMe.setImageResource(R.drawable.check);
                ChkInternetMe.setTag("1");
            } else {
                ChkInternetMe.setImageResource(R.drawable.uncheck);
                ChkInternetMe.setTag("0");
            }
        } else if (v == chkPhoneMe || v == imgMePhone) {
            if (chkPhoneMe.getTag().equals("0")) {
                chkPhoneMe.setImageResource(R.drawable.check);
                chkPhoneMe.setTag("1");
            } else {
                chkPhoneMe.setImageResource(R.drawable.uncheck);
                chkPhoneMe.setTag("0");
            }
        } else if (v == chkCableMe || v == imgMeCable) {
            if (chkCableMe.getTag().equals("0")) {
                chkCableMe.setImageResource(R.drawable.check);
                chkCableMe.setTag("1");
            } else {
                chkCableMe.setImageResource(R.drawable.uncheck);
                chkCableMe.setTag("0");
            }
        } else if (v == chkCellNub) {
            chkCellNub.setImageResource(R.drawable.check);
            chkEmail.setImageResource(R.drawable.uncheck);
            chkCellNub.setTag("1");
            chkEmail.setTag("0");
            txtCellNumber.setEnabled(true);
            txtEmail.setEnabled(false);

        } else if (v == chkEmail) {
            chkEmail.setImageResource(R.drawable.check);
            chkCellNub.setImageResource(R.drawable.uncheck);
            chkCellNub.setTag("0");
            chkEmail.setTag("1");
            txtCellNumber.setEnabled(false);
            txtEmail.setEnabled(true);
        }
    }

    private void fillCheckBox() {
        String service_name = getArguments().getString(FragRequestProposal.EXTRA_SERVICES);
        //String service_name = getArguments().getString("Internet");
        if (service_name.equals("Internet")) {
            ChkInternetMe.setImageResource(R.drawable.check);
            ChkInternetMe.setTag("1");
        } else if (service_name.equals("Phone Service")) {
            chkPhoneMe.setImageResource(R.drawable.check);
            chkPhoneMe.setTag("1");
        } else if (service_name.equals("Cabling")) {
            chkCableMe.setImageResource(R.drawable.check);
            chkCableMe.setTag("1");
        }
    }

    private void validateForm() {
        String cell_number = txtCellNumber.getText().toString().trim();
        String email = txtEmail.getText().toString().trim();
        String msg = txtMsg.getText().toString().trim();

        //--------------------------------------
        /*if (chkCellNub.getTag().equals("0") && chkEmail.getTag().equals("0")) {
            IRoidAppHelper.showAlert(root, "Please Give Cell Number Or Email");
            return;
        } else {
            //--------------------------------------
            if (chkCellNub.getTag().equals("1")) {
                if (cell_number.equals("")) {
                    IRoidAppHelper.showAlert(getActivity(), getString(R.string.empty_cell_num));
                    return;
                } else {
                    txtCellNumber.setError(null);
                }

            } else {
                txtCellNumber.setError(null);
            }
            //--------------------------------------
            if (chkEmail.getTag().equals("1")) {
                if (email.equals("")) {
                    IRoidAppHelper.showAlert(getActivity(), getString(R.string.enterEmail));
                    return;
                } else {
                    if (IRoidAppHelper.IsValidEmailAddress(email) == false) {
                        IRoidAppHelper.showAlert(getActivity(), getString(R.string.invalidEmail));
                        return;
                    }
                }
            } else {
                txtEmail.setError(null);
            }
            //-----------------------------------
        }*/
        //--------------------------------------
        if (msg.equals("")) {
            IRoidAppHelper.showAlert(getActivity(), getString(R.string.empty_mess));
            return;
        } else {
            txtMsg.setError(null);
        }
        //--------------------------------------
       /* if (ChkInternetMe.getTag().equals("0") && chkPhoneMe.getTag().equals("0") && chkCableMe.getTag().equals("0")) {
            IRoidAppHelper.showAlert(getActivity(), getString(R.string.empty_service));
            return;
        }*/
        //--------------------------------------
        LocalStorage localStorage = new LocalStorage(getActivity());
        String user_id = localStorage.GetItem(LocalStorage.user_id);
        String agent_uniq_id = localStorage.GetItem(LocalStorage.agent_uniq_id);
        String service_name = getArguments().getString(FragRequestProposal.EXTRA_SERVICES);

        if (IRoidAppHelper.isNetworkAvailable(getActivity())) {
            CallMeRequest callMeRequest = new CallMeRequest();
            if (user_id.equals("")) {
                callMeRequest.setUserId("-1");
            } else {
                callMeRequest.setUserId(user_id);
            }
            //callMeRequest.setAgentUniqId(agent_uniq_id);
            if (ChkInternetMe.getTag().equals("1") && chkPhoneMe.getTag().equals("1") && chkCableMe.getTag().equals("1")) {
                name_of_service = "Internet,Phone Service,Cabling";
                callMeRequest.setService(name_of_service);
            } else if (ChkInternetMe.getTag().equals("1") && chkPhoneMe.getTag().equals("1")) {
                name_of_service = "Internet,Phone Service";
                callMeRequest.setService(name_of_service);
            } else if (ChkInternetMe.getTag().equals("1") && chkCableMe.getTag().equals("1")) {
                name_of_service = "Internet,Cabling";
                callMeRequest.setService(name_of_service);
            } else if (chkPhoneMe.getTag().equals("1") && chkCableMe.getTag().equals("1")) {
                name_of_service = "Phone Service,Cabling";
                callMeRequest.setService(name_of_service);
            } else if (ChkInternetMe.getTag().equals("1")) {
                name_of_service = "Internet";
                callMeRequest.setService(name_of_service);
            } else if (chkPhoneMe.getTag().equals("1")) {
                name_of_service = "Phone Service";
                callMeRequest.setService(service_name);
            } else if (chkCableMe.getTag().equals("1")) {
                name_of_service = "Cabling";
                callMeRequest.setService(name_of_service);
            }

            /*if (chkCellNub.getTag().equals("1")) {
                callMeRequest.setCellNumber(cell_number);
                callMeRequest.setEmailId("");
            } else {
                callMeRequest.setCellNumber("");
                callMeRequest.setEmailId(email);
            }*/

            callMeRequest.setCellNumber(cell_number);
            callMeRequest.setEmailId(email);
            callMeRequest.setMessage(msg);
            callcall_meAPI(callMeRequest);
        } else {
            IRoidAppHelper.showAlert(getActivity(), getString(R.string.internet_error));
        }
    }
    //--------------------call_me--------------------------------------------------------

    private void callcall_meAPI(CallMeRequest callMeRequest) {
        loadingView.setVisibility(View.VISIBLE);
        WebAPIClient.getInstance(root).call_me(callMeRequest, new Callback<CallMeResponse>() {
            @Override
            public void onResponse(Call<CallMeResponse> call, Response<CallMeResponse> response) {
                loadingView.setVisibility(View.GONE);
                CallMeResponse callMeResponse = response.body();

                if (callMeResponse.getFlag().equals("true")) {
                    IRoidAppHelper.showAlert(getActivity(), getString(R.string.call_succes));
                    //txtCellNumber.setText("");
                    //txtEmail.setText("");
                    txtMsg.setText("");
                    if (chkCellNub.getTag().equals("1")) {
                        chkCellNub.setTag("0");
                        chkCellNub.setImageResource(R.drawable.uncheck);
                    }
                    if (chkEmail.getTag().equals("1")) {
                        chkEmail.setTag("0");
                        chkEmail.setImageResource(R.drawable.uncheck);
                    }
                } else {
                    if (callMeResponse.getCode() == 99) {
                        showRegisterAlert(callMeResponse.getMsg());
                    } else {
                        IRoidAppHelper.showAlert(root, callMeResponse.getMsg());
                    }
                }
            }

            @Override
            public void onFailure(Call<CallMeResponse> call, Throwable t) {
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
