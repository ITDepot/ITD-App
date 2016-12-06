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
import com.patrick.itdepot.framework.contactclient.ContactClientRequest;
import com.patrick.itdepot.framework.contactclient.ContactClientResponse;
import com.patrick.itdepot.helper.IRoidAppHelper;
import com.patrick.itdepot.helper.LocalStorage;
import com.patrick.itdepot.webapis.WebAPIClient;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by iroid on 9/19/2016.
 */
public class FragContactClient extends Fragment implements View.OnClickListener {

    private ActMain root;

    private ImageView chkIntClient;
    private ImageView chkPhoneClient;
    private ImageView chkCableClient;
    private EditText txtBusinessName;
    private EditText txtContactNm;
    private EditText txtCellNumber;
    private EditText txtClientMail;
    private EditText txtClientMsg;
    private RelativeLayout relContactClient;
    private LinearLayout loadingView;
    private ImageView imgClientInt, imgClientPhone, imgClientCable;
    private String service_of_Client;

    private void findViews() {
        View view = getView();
        chkIntClient = (ImageView) view.findViewById(R.id.chkIntClient);
        chkPhoneClient = (ImageView) view.findViewById(R.id.chkPhoneClient);
        chkCableClient = (ImageView) view.findViewById(R.id.chkCableClient);
        txtBusinessName = (EditText) view.findViewById(R.id.txtBusinessName);
        txtContactNm = (EditText) view.findViewById(R.id.txtContactNm);
        txtCellNumber = (EditText) view.findViewById(R.id.txtCellNumber);
        txtClientMail = (EditText) view.findViewById(R.id.txtClientMail);
        txtClientMsg = (EditText) view.findViewById(R.id.txtClientMsg);
        relContactClient = (RelativeLayout) view.findViewById(R.id.relContactClient);
        loadingView = (LinearLayout) view.findViewById(R.id.loadingView);

        imgClientInt = (ImageView) view.findViewById(R.id.imgClientInt);
        imgClientPhone = (ImageView) view.findViewById(R.id.imgClientPhone);
        imgClientCable = (ImageView) view.findViewById(R.id.imgClientCable);

        relContactClient.setOnClickListener(this);
        chkIntClient.setOnClickListener(this);
        chkPhoneClient.setOnClickListener(this);
        chkCableClient.setOnClickListener(this);
        imgClientInt.setOnClickListener(this);
        imgClientPhone.setOnClickListener(this);
        imgClientCable.setOnClickListener(this);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.frag_contact_client, container, false);
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
        if (v == relContactClient) {
            validateForm();
        } else if (v == chkIntClient || v == imgClientInt) {

            if (chkIntClient.getTag().equals("0")) {
                chkIntClient.setImageResource(R.drawable.check);
                chkIntClient.setTag("1");
            } else {
                chkIntClient.setImageResource(R.drawable.uncheck);
                chkIntClient.setTag("0");
            }

        } else if (v == chkPhoneClient || v == imgClientPhone) {
            if (chkPhoneClient.getTag().equals("0")) {
                chkPhoneClient.setImageResource(R.drawable.check);
                chkPhoneClient.setTag("1");
            } else {
                chkPhoneClient.setImageResource(R.drawable.uncheck);
                chkPhoneClient.setTag("0");
            }
        } else if (v == chkCableClient || v == imgClientCable) {
            if (chkCableClient.getTag().equals("0")) {
                chkCableClient.setImageResource(R.drawable.check);
                chkCableClient.setTag("1");
            } else {
                chkCableClient.setImageResource(R.drawable.uncheck);
                chkCableClient.setTag("0");
            }
        }
    }

    private void fillCheckBox() {
        String service_name = getArguments().getString(FragRequestProposal.EXTRA_SERVICES);
        if (service_name.equals("Internet")) {
            chkIntClient.setImageResource(R.drawable.check);
            chkIntClient.setTag("1");
        } else if (service_name.equals("Phone Service")) {
            chkPhoneClient.setImageResource(R.drawable.check);
            chkPhoneClient.setTag("1");
        } else if (service_name.equals("Cabling")) {
            chkCableClient.setImageResource(R.drawable.check);
            chkCableClient.setTag("1");
        }
    }


    private void validateForm() {
        String businessName = txtBusinessName.getText().toString().trim();
        String contact_name = txtContactNm.getText().toString().trim();
        String client_cell = txtCellNumber.getText().toString().trim();
        String client_email = txtClientMail.getText().toString().trim();
        String client_msg = txtClientMsg.getText().toString().trim();


       /* if (businessName.equals("")) {
            IRoidAppHelper.showAlert(getActivity(), getString(R.string.empty_business_nm));
            return;
        } else {
            txtBusinessName.setError(null);
        }
*/
        //--------------------------------------
       /* if (contact_name.equals("")) {
            IRoidAppHelper.showAlert(getActivity(), getString(R.string.empty_Contact_nm));
            return;
        } else {
            txtContactNm.setError(null);
        }*/
        //--------------------------------------
       /* if (client_cell.equals("")) {
            IRoidAppHelper.showAlert(getActivity(), getString(R.string.empty_contact_nub));
            return;
        } else {
            txtCellNumber.setError(null);
        }*/
        //--------------------------------------
       /* if (client_email.equals("")) {
            IRoidAppHelper.showAlert(getActivity(), getString(R.string.empty_email));
            return;
        } else {
            if (IRoidAppHelper.IsValidEmailAddress(client_email) == false) {
                IRoidAppHelper.showAlert(getActivity(), getString(R.string.invali_email));
                return;
            }
        }*/


        if (!client_email.equals("")) {
            if (IRoidAppHelper.IsValidEmailAddress(client_email) == false) {
                IRoidAppHelper.showAlert(getActivity(), getString(R.string.invali_email));
                return;
            }
        }

        //--------------------------------------
        if (client_msg.equals("")) {
            IRoidAppHelper.showAlert(getActivity(), getString(R.string.empty_messages));
            return;
        } else {
            txtClientMsg.setError(null);
        }
        //--------------------------------------
        if (chkIntClient.getTag().equals("0") && chkPhoneClient.getTag().equals("0") && chkCableClient.getTag().equals("0")) {
            IRoidAppHelper.showAlert(getActivity(), getString(R.string.empty_service));
            return;
        }

        //--------------------------------------

        LocalStorage localStorage = new LocalStorage(getActivity());
        String user_id = localStorage.GetItem(LocalStorage.user_id);

        ContactClientRequest contactClientRequest = new ContactClientRequest();
        if (user_id.equals("")) {
            contactClientRequest.setUserId("-1");
        } else {
            contactClientRequest.setUserId(user_id);
        }

        if (chkIntClient.getTag().equals("1") && chkPhoneClient.getTag().equals("1") && chkCableClient.getTag().equals("1")) {
            service_of_Client = "Internet,Phone Service,Cabling";
            contactClientRequest.setService(service_of_Client);
        } else if (chkIntClient.getTag().equals("1") && chkPhoneClient.getTag().equals("1")) {
            service_of_Client = "Internet,Phone Service";
            contactClientRequest.setService(service_of_Client);
        } else if (chkIntClient.getTag().equals("1") && chkCableClient.getTag().equals("1")) {
            service_of_Client = "Internet,Cabling";
            contactClientRequest.setService(service_of_Client);
        } else if (chkPhoneClient.getTag().equals("1") && chkCableClient.getTag().equals("1")) {
            service_of_Client = "Phone Service,Cabling";
            contactClientRequest.setService(service_of_Client);
        } else if (chkIntClient.getTag().equals("1")) {
            service_of_Client = "Internet";
            contactClientRequest.setService(service_of_Client);
        } else if (chkPhoneClient.getTag().equals("1")) {
            service_of_Client = "Phone Service";
            contactClientRequest.setService(service_of_Client);
        } else if (chkCableClient.getTag().equals("1")) {
            service_of_Client = "Cabling";
            contactClientRequest.setService(service_of_Client);
        }
        contactClientRequest.setBusinessName(businessName);
        contactClientRequest.setContactName(contact_name);
        contactClientRequest.setContactPhone(client_cell);
        contactClientRequest.setContactEmail(client_email);
        contactClientRequest.setMessage(client_msg);
        callcontact_the_clientAPI(contactClientRequest);
        //--------------------------------------

    }

    //---------------------------contact_the_client-------------------------------------------------

    private void callcontact_the_clientAPI(ContactClientRequest contactClientRequest) {
        loadingView.setVisibility(View.VISIBLE);
        WebAPIClient.getInstance(root).contact_the_client(contactClientRequest, new Callback<ContactClientResponse>() {
            @Override
            public void onResponse(Call<ContactClientResponse> call, Response<ContactClientResponse> response) {
                loadingView.setVisibility(View.GONE);
                ContactClientResponse contactClientResponse = response.body();


                if (contactClientResponse.getFlag().equals("true")) {
                    IRoidAppHelper.showAlert(getActivity(), getString(R.string.client_success));
                    txtBusinessName.setText("");
                    txtContactNm.setText("");
                    txtCellNumber.setText("");
                    txtClientMail.setText("");
                    txtClientMsg.setText("");
                } else {
                    /*txtBusinessName.setText("");
                    txtContactNm.setText("");
                    txtCellNumber.setText("");
                    txtClientMail.setText("");
                    txtClientMsg.setText("");
                    IRoidAppHelper.showAlert(root, contactClientResponse.getMsg());*/

                    if (contactClientResponse.getCode() == 99) {
                        showRegisterAlert(contactClientResponse.getMsg());
                    } else {
                        IRoidAppHelper.showAlert(root, contactClientResponse.getMsg());
                    }

                }
            }

            @Override
            public void onFailure(Call<ContactClientResponse> call, Throwable t) {
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
