import plotly
import pandas as pd
cdf_df = pd.read_csv("CDF.txt", sep = '\t')
cdf_df['fuck'] = cdf_df.value.to_dense()
cdf_df = cdf_df.tail(5000)

fig = {
    'data': [
        {
            'x': cdf_df[cdf_df['type']==type]['fuck'],
            'y': cdf_df[cdf_df['type']==type]['value'],
            'name': type, 'mode': 'markers',
        } for type in ['protein_coding', 'known_lncRNA', 'novel_lncRNA']
    ],
    'layout': {
        'xaxis': {'title': 'Fuck'},
        'yaxis': {'title': "CDF"}
    }
}

plotly.offline.plot(fig)