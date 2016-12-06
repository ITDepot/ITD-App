package com.patrick.itdepot.fragments;

import android.app.Activity;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.patrick.itdepot.R;
import com.patrick.itdepot.activity.ActMain;

/**
 * Created by iroid on 9/29/2016.
 */
public class FragResources extends Fragment {
    private ActMain root;

    private ImageView imgRes1;
    private ImageView imgRes2;
    private ImageView imgRes3;
    private TextView lblTechName;

    private String CURRENT_TYPE = "";

    private void findViews() {
        View view = getView();
        imgRes1 = (ImageView) view.findViewById(R.id.imgRes1);
        imgRes2 = (ImageView) view.findViewById(R.id.imgRes2);
        imgRes3 = (ImageView) view.findViewById(R.id.imgRes3);
        lblTechName = (TextView) view.findViewById(R.id.lblTechName);

        imgRes1.setOnClickListener(onImageClickListner);
        imgRes2.setOnClickListener(onImageClickListner);
        imgRes3.setOnClickListener(onImageClickListner);

        String service_name = getArguments().getString(FragRequestProposal.EXTRA_SERVICES);
        CURRENT_TYPE = service_name;
        setImageAccordingType(service_name);
    }

    View.OnClickListener onImageClickListner = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            CURRENT_TYPE = v.getTag().toString();
            setImageAccordingType(v.getTag().toString());
        }
    };

    private void setImageAccordingType(String service_name) {
        if (service_name.equals(FragRequestProposal.TYPE_INTERNET)) {
            lblTechName.setText(getString(R.string.internet));
            imgRes2.setImageResource(R.drawable.new_selected_internet);
            imgRes1.setImageResource(R.drawable.phone_service_button);
            imgRes3.setImageResource(R.drawable.cabling_button);

            imgRes1.setTag(FragRequestProposal.TYPE_PHONE_SERVICE);
            imgRes2.setTag(FragRequestProposal.TYPE_INTERNET);
            imgRes3.setTag(FragRequestProposal.TYPE_CABLING);

            getChildFragmentManager().beginTransaction().replace(R.id.fragContainerResource, new FragInternet().newInstance(FragRequestProposal.TYPE_INTERNET)).commit();

        } else if (service_name.equals(FragRequestProposal.TYPE_PHONE_SERVICE)) {
            lblTechName.setText(getString(R.string.phone_services));
            imgRes2.setImageResource(R.drawable.selected_phone_service);
            imgRes1.setImageResource(R.drawable.internet_button);
            imgRes3.setImageResource(R.drawable.cabling_button);

            imgRes2.setTag(FragRequestProposal.TYPE_PHONE_SERVICE);
            imgRes1.setTag(FragRequestProposal.TYPE_INTERNET);
            imgRes3.setTag(FragRequestProposal.TYPE_CABLING);

            getChildFragmentManager().beginTransaction().replace(R.id.fragContainerResource, new FragPhoneService().newInstance(FragRequestProposal.TYPE_PHONE_SERVICE)).commit();

        } else if (service_name.equals(FragRequestProposal.TYPE_CABLING)) {
            lblTechName.setText(getString(R.string.cabling));
            imgRes2.setImageResource(R.drawable.selected_cabling_icon);
            imgRes1.setImageResource(R.drawable.internet_button);
            imgRes3.setImageResource(R.drawable.phone_service_button);

            imgRes3.setTag(FragRequestProposal.TYPE_PHONE_SERVICE);
            imgRes1.setTag(FragRequestProposal.TYPE_INTERNET);
            imgRes2.setTag(FragRequestProposal.TYPE_CABLING);

            getChildFragmentManager().beginTransaction().replace(R.id.fragContainerResource, new FragCabling().newInstance(FragRequestProposal.TYPE_CABLING)).commit();
        }
    }


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.frag_resources, container, false);
    }

    @Override
    public void onStart() {
        super.onStart();
        root.setMenuTitle(getString(R.string.back_page));
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

    //----------------------------------------------------------------------------------------------
}
