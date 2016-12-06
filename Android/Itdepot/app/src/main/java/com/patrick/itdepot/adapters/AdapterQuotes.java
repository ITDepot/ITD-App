package com.patrick.itdepot.adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import com.patrick.itdepot.R;
import com.patrick.itdepot.framework.getquotes.GetQuotes;

import java.util.List;

/**
 * Created by iroid on 8/24/2016.
 */
public class AdapterQuotes extends ArrayAdapter<GetQuotes> {

    private Context context;
    private List<GetQuotes> objects;

    public AdapterQuotes(Context context, int resource, List<GetQuotes> objects) {
        super(context, resource, objects);
        this.context = context;
        this.objects = objects;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder vh = null;
        if (convertView == null) {
            vh = new ViewHolder();
            convertView = LayoutInflater.from(context).inflate(R.layout.cell_quotes, null);

            vh.lblQuoteReqtd = (TextView) convertView.findViewById(R.id.lblQuoteReqtd);
            vh.lblClient = (TextView) convertView.findViewById(R.id.lblClient);
            vh.lblServices = (TextView) convertView.findViewById(R.id.lblServices);

            convertView.setTag(vh);
        } else {
            vh = (ViewHolder) convertView.getTag();
        }
        vh.lblQuoteReqtd.setText(objects.get(position).getRequested());
        vh.lblClient.setText(objects.get(position).getClientName());
        vh.lblServices.setText(objects.get(position).getService());
        return convertView;
    }

    private class ViewHolder {
        TextView lblQuoteReqtd;
        TextView lblClient;
        TextView lblServices;
    }
}
