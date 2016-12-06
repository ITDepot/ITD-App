package com.patrick.itdepot.fragments;

import android.app.Activity;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.patrick.itdepot.R;
import com.patrick.itdepot.activity.ActMain;
import com.patrick.itdepot.helper.LocalStorage;

/**
 * Created by iroid on 8/26/2016.
 */
public class FragActivityReportOld extends Fragment implements View.OnClickListener {
    private LinearLayout llQuote;
    private View viewQuote;
    private LinearLayout llInstallpending;
    private View viewPending;
    private LinearLayout llNrIncome, llEdit;
    private View viewNrIncome;
    private LinearLayout llMrIncome;
    private View viewMrIncome;
    private ViewPager pagerAccount;
    private ActMain root;
    private RelativeLayout relEdit;
    private TextView lblFnameAct, lblEmailAct, lblPhoneAct;

    private PagerAdapter pagerAdapter;


    private void findViews() {
        View view = getView();
        llQuote = (LinearLayout) view.findViewById(R.id.llQuote);
        viewQuote = (View) view.findViewById(R.id.viewQuote);
        llInstallpending = (LinearLayout) view.findViewById(R.id.llInstallpending);
        viewPending = (View) view.findViewById(R.id.viewPending);
        llNrIncome = (LinearLayout) view.findViewById(R.id.llNrIncome);
        viewNrIncome = (View) view.findViewById(R.id.viewNrIncome);
        llMrIncome = (LinearLayout) view.findViewById(R.id.llMrIncome);
        viewMrIncome = (View) view.findViewById(R.id.viewMrIncome);
        pagerAccount = (ViewPager) view.findViewById(R.id.pagerAccount);
        lblFnameAct = (TextView) view.findViewById(R.id.lblFnameAct);
        lblEmailAct = (TextView) view.findViewById(R.id.lblEmailAct);
        lblPhoneAct = (TextView) view.findViewById(R.id.lblPhoneAct);
        llEdit = (LinearLayout) view.findViewById(R.id.llEdit);
        relEdit = (RelativeLayout) view.findViewById(R.id.relEdit);

        llQuote.setOnClickListener(this);
        llInstallpending.setOnClickListener(this);
        llNrIncome.setOnClickListener(this);
        llMrIncome.setOnClickListener(this);
        llEdit.setOnClickListener(this);
        relEdit.setOnClickListener(this);

        llQuote.setBackgroundResource(R.drawable.textview_activity);
        viewQuote.setBackgroundResource(R.drawable.view_activity);


        pagerAccount.setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

            }

            @Override
            public void onPageSelected(int position) {
                if (position == 0) {
                    pagerAccount.setCurrentItem(0);

                    llQuote.setBackgroundResource(R.drawable.textview_activity);
                    llInstallpending.setBackgroundResource(R.drawable.textview_gray);
                    llNrIncome.setBackgroundResource(R.drawable.textview_gray);
                    llMrIncome.setBackgroundResource(R.drawable.textview_gray);
                    viewQuote.setBackgroundResource(R.drawable.view_activity);
                    viewPending.setBackgroundResource(R.drawable.view_gray);
                    viewNrIncome.setBackgroundResource(R.drawable.view_gray);
                    viewMrIncome.setBackgroundResource(R.drawable.view_gray);

                } else if (position == 1) {
                    pagerAccount.setCurrentItem(1);

                    llQuote.setBackgroundResource(R.drawable.textview_gray);
                    llInstallpending.setBackgroundResource(R.drawable.textview_activity);
                    llNrIncome.setBackgroundResource(R.drawable.textview_gray);
                    llMrIncome.setBackgroundResource(R.drawable.textview_gray);
                    viewQuote.setBackgroundResource(R.drawable.view_gray);
                    viewPending.setBackgroundResource(R.drawable.view_activity);
                    viewNrIncome.setBackgroundResource(R.drawable.view_gray);
                    viewMrIncome.setBackgroundResource(R.drawable.view_gray);

                } else if (position == 2) {
                    pagerAccount.setCurrentItem(2);

                    llQuote.setBackgroundResource(R.drawable.textview_gray);
                    llInstallpending.setBackgroundResource(R.drawable.textview_gray);
                    llNrIncome.setBackgroundResource(R.drawable.textview_activity);
                    llMrIncome.setBackgroundResource(R.drawable.textview_gray);
                    viewQuote.setBackgroundResource(R.drawable.view_gray);
                    viewPending.setBackgroundResource(R.drawable.view_gray);
                    viewNrIncome.setBackgroundResource(R.drawable.view_activity);
                    viewMrIncome.setBackgroundResource(R.drawable.view_gray);

                } else if (position == 3) {
                    pagerAccount.setCurrentItem(3);

                    llQuote.setBackgroundResource(R.drawable.textview_gray);
                    llInstallpending.setBackgroundResource(R.drawable.textview_gray);
                    llNrIncome.setBackgroundResource(R.drawable.textview_gray);
                    llMrIncome.setBackgroundResource(R.drawable.textview_activity);
                    viewQuote.setBackgroundResource(R.drawable.view_gray);
                    viewPending.setBackgroundResource(R.drawable.view_gray);
                    viewNrIncome.setBackgroundResource(R.drawable.view_gray);
                    viewMrIncome.setBackgroundResource(R.drawable.view_activity);
                }
            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });

    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.frag_activity_report, container, false);
    }

    @Override
    public void onStart() {
        super.onStart();
        root.setMenuTitle(getString(R.string.back_page));
        root.setServiceButton(View.GONE);
        root.setMenuImage(getResources().getDrawable(R.drawable.back));
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

    @Override
    public void onClick(View v) {
        if (v == llQuote) {
            pagerAccount.setCurrentItem(0);

            llQuote.setBackgroundResource(R.drawable.textview_activity);
            llInstallpending.setBackgroundResource(R.drawable.textview_gray);
            llNrIncome.setBackgroundResource(R.drawable.textview_gray);
            llMrIncome.setBackgroundResource(R.drawable.textview_gray);
            viewQuote.setBackgroundResource(R.drawable.view_activity);
            viewPending.setBackgroundResource(R.drawable.view_gray);
            viewNrIncome.setBackgroundResource(R.drawable.view_gray);
            viewMrIncome.setBackgroundResource(R.drawable.view_gray);

        } else if (v == llInstallpending) {
            pagerAccount.setCurrentItem(1);

            llQuote.setBackgroundResource(R.drawable.textview_gray);
            llInstallpending.setBackgroundResource(R.drawable.textview_activity);
            llNrIncome.setBackgroundResource(R.drawable.textview_gray);
            llMrIncome.setBackgroundResource(R.drawable.textview_gray);
            viewQuote.setBackgroundResource(R.drawable.view_gray);
            viewPending.setBackgroundResource(R.drawable.view_activity);
            viewNrIncome.setBackgroundResource(R.drawable.view_gray);
            viewMrIncome.setBackgroundResource(R.drawable.view_gray);

        } else if (v == llNrIncome) {
            pagerAccount.setCurrentItem(2);

            llQuote.setBackgroundResource(R.drawable.textview_gray);
            llInstallpending.setBackgroundResource(R.drawable.textview_gray);
            llNrIncome.setBackgroundResource(R.drawable.textview_activity);
            llMrIncome.setBackgroundResource(R.drawable.textview_gray);
            viewQuote.setBackgroundResource(R.drawable.view_gray);
            viewPending.setBackgroundResource(R.drawable.view_gray);
            viewNrIncome.setBackgroundResource(R.drawable.view_activity);
            viewMrIncome.setBackgroundResource(R.drawable.view_gray);

        } else if (v == llMrIncome) {
            pagerAccount.setCurrentItem(3);

            llQuote.setBackgroundResource(R.drawable.textview_gray);
            llInstallpending.setBackgroundResource(R.drawable.textview_gray);
            llNrIncome.setBackgroundResource(R.drawable.textview_gray);
            llMrIncome.setBackgroundResource(R.drawable.textview_activity);
            viewQuote.setBackgroundResource(R.drawable.view_gray);
            viewPending.setBackgroundResource(R.drawable.view_gray);
            viewNrIncome.setBackgroundResource(R.drawable.view_gray);
            viewMrIncome.setBackgroundResource(R.drawable.view_activity);

        } else if (v == llEdit || v == relEdit) {
            gotoRegister();
        }
    }

    private void fillData() {
        LocalStorage localStorage = new LocalStorage(getActivity());
        String fname = localStorage.GetItem(LocalStorage.firstname);
        String email = localStorage.GetItem(LocalStorage.email_id);
        String phone_nub = localStorage.GetItem(LocalStorage.phone);

        lblFnameAct.setText(fname);
        lblEmailAct.setText(email);
        lblPhoneAct.setText(phone_nub);

        pagerAccount.setAdapter(new PagerAdapter(getChildFragmentManager()));
        pagerAccount.setOffscreenPageLimit(4);
    }

    //----------------------------------------------------------------------------------------------
    private class PagerAdapter extends FragmentPagerAdapter {

        public PagerAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public Fragment getItem(int position) {
            Fragment fragment = null;
            switch (position) {
                case 0:
                    fragment = Fragment.instantiate(getActivity(), FragQuotes.class.getName());
                    break;
                case 1:
                    fragment = Fragment.instantiate(getActivity(), FragInstallPending.class.getName());
                    break;
                case 2:
                    fragment = Fragment.instantiate(getActivity(), FragNonRecurring.class.getName());
                    break;
                case 3:
                    fragment = Fragment.instantiate(getActivity(), FragMonthlyRecurring.class.getName());
                    break;
                default:
                    return null;
            }
            return fragment;
        }

        @Override
        public int getCount() {
            return 4;
        }
    }

    //----------------------------------------------------------------------------------------------
    private void gotoRegister() {
        FragmentTransaction fragmentTransaction = getActivity().getSupportFragmentManager().beginTransaction();
        FragRegister fragDummy = new FragRegister();
        fragmentTransaction.setCustomAnimations(R.anim.slide_in_left, R.anim.slide_out_left, R.anim.slide_in_right, R.anim.slide_out_right);
        fragDummy.setAction(getString(R.string.edit_));
        fragmentTransaction.replace(R.id.fragContainer, fragDummy, FragRegister.class.getName());
        fragmentTransaction.addToBackStack(FragRegister.class.getName());
        fragmentTransaction.commit();
    }
    //----------------------------------------------------------------------------------------------
}
