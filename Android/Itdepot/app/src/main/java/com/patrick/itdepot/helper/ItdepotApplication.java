package com.patrick.itdepot.helper;

import android.app.Application;

import com.patrick.itdepot.R;

import uk.co.chrisjenx.calligraphy.CalligraphyConfig;

/**
 * Created by iroid on 8/26/2016.
 */
public class ItdepotApplication extends Application {
    @Override
    public void onCreate() {

        CalligraphyConfig.initDefault(new CalligraphyConfig.Builder()
                .setDefaultFontPath("fonts/Campton-Medium.ttf")
                .setFontAttrId(R.attr.fontPath)
                .build()
        );

        super.onCreate();
    }
}
