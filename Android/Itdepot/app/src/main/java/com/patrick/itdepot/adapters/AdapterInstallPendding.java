package com.patrick.itdepot.adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import com.patrick.itdepot.R;
import com.patrick.itdepot.framework.getinstallpendding.GetinstallPendding;

import java.util.List;


public class AdapterInstallPendding extends ArrayAdapter<GetinstallPendding> {

    private Context context;
    private List<GetinstallPendding> objects;

    public AdapterInstallPendding(Context context, int resource, List<GetinstallPendding> objects) {
        super(context, resource, objects);
        this.context = context;
        this.objects = objects;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder vh = null;
        if (convertView == null) {
            vh = new ViewHolder();
            convertView = LayoutInflater.from(context).inflate(R.layout.cell_install_pending, null);

            vh.lblClientPending = (TextView) convertView.findViewById(R.id.lblClientPending);
            vh.lblServicesPending = (TextView) convertView.findViewById(R.id.lblServicesPending);
            vh.lblNrIncomePending = (TextView) convertView.findViewById(R.id.lblNrIncomePending);
            vh.lblMrIncomePending = (TextView) convertView.findViewById(R.id.lblMrIncomePending);
            vh.lblEstPending = (TextView) convertView.findViewById(R.id.lblEstPending);

            convertView.setTag(vh);
        } else {
            vh = (ViewHolder) convertView.getTag();
        }
        vh.lblClientPending.setText(objects.get(position).getClientName());
        vh.lblServicesPending.setText(objects.get(position).getService());
        vh.lblNrIncomePending.setText(objects.get(position).getNrIncome());
        vh.lblMrIncomePending.setText(objects.get(position).getMrIncome());
        vh.lblEstPending.setText(objects.get(position).getEstInstall());

        return convertView;
    }

    @Override
    public int getCount() {
        return objects.size();
    }

    private class ViewHolder {
        TextView lblClientPending;
        TextView lblServicesPending;
        TextView lblNrIncomePending;
        TextView lblMrIncomePending;
        TextView lblEstPending;
    }
}
