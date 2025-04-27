import os
import pandas as pd
import numpy as np
from dotenv import load_dotenv, find_dotenv
from bokeh.io import curdoc
from bokeh.layouts import column, row
from bokeh.plotting import figure
from bokeh.models import ColumnDataSource, DataTable, TableColumn
from bokeh.models import Div, HoverTool, Title
from bokeh.models import LogScale, LogTicker, LogTickFormatter, NumeralTickFormatter
from bokeh.models import Slider, Spacer
from bokeh.models import CategoricalColorMapper
from bokeh.palettes import Category10

# Load environment variables
load_dotenv(find_dotenv(usecwd=True))
data_folder = os.getenv('DATA_FOLDER')

# Load the dataset
df = pd.read_csv(os.path.join(data_folder, 'co2_gdp', 'co2_gdp_country.csv'))

# --------------------------------------
# Create title
# --------------------------------------
title = Div(text="""<h1 style='text-align: center; color: #3366cc;'>Sample Dashboard on the CO2 Emissions Dataset</h1>""",
            width=800, height=50)

# --------------------------------------
# DATASET OVERVIEW SECTION
# --------------------------------------
overview_title = Div(text="""<h2 style='color: #3366cc;'>Dataset Overview</h2>""",
                    width=800, height=30)

# Table of columns with datatype
column_types = pd.DataFrame({
    'Column': df.columns,
    'Data Type': [str(df[col].dtype) for col in df.columns]
})
source_column_types = ColumnDataSource(column_types)
columns = [
    TableColumn(field="Column", title="Column Name"),
    TableColumn(field="Data Type", title="Data Type")
]
data_table = DataTable(source=source_column_types, columns=columns, width=400, height=150, index_position=None)


# Overview section - Layout elements
overview_section = column(
    overview_title,
    data_table,
    row(
        Div(text="""<div style="display: flex; align-items: center; height: 40px;"><h3 style="margin: 0;">Number of Rows:</h3></div>""", width=150, height=40),
        Div(text=f"""<div style="display: flex; align-items: center; height: 40px;"><span style='color: #3366cc; font-size: 1.5em; margin: 0;'>{len(df)}</span></div>""", width=100, height=40),
        Spacer(width=20),
        Div(text="""<div style="display: flex; align-items: center; height: 40px;"><h3 style="margin: 0;">Year Range:</h3></div>""", width=150, height=40),
        Div(text=f"""<div style="display: flex; align-items: center; height: 40px;"><span style='color: #3366cc; font-size: 1.5em; margin: 0;'>{df['year'].min()} - {df['year'].max()}</span></div>""", width=200, height=40),
        Spacer(width=20),
        Div(text="""<div style="display: flex; align-items: center; height: 40px;"><h3 style="margin: 0;">Number of Countries:</h3></div>""", width=150, height=40),
        Div(text=f"""<div style="display: flex; align-items: center; height: 40px;"><span style='color: #3366cc; font-size: 1.5em; margin: 0;'>{len(df['country'].unique())}</span></div>""", width=100, height=40),
        sizing_mode="scale_width"
    ), 
    sizing_mode="scale_width"
)

# --------------------------------------
# CO2 EMISSIONS UNIVARIATE ANALYSIS SECTION
# --------------------------------------
co2_title = Div(text="""<h2 style='color: #3366cc;'>Univariate Analysis: CO2</h2>""",
                width=800, height=50)

# Section placeholder
co2_section = column(
    co2_title,
    Div(text="""<p style='color: #666666;'>[Exercise: Complete this section]</p>"""),
    sizing_mode="stretch_width"
)

# --------------------------------------
# GDP UNIVARIATE ANALYSIS SECTION
# --------------------------------------
gdp_title = Div(text="""<h2 style='color: #3366cc;'>Univariate Analysis: GDP</h2>""",
                width=800, height=50)

# Section placeholder
gdp_section = column(
    gdp_title,
    Div(text="""<p style='color: #666666;'>[Exercise: Complete this section]</p>"""),
    sizing_mode="stretch_width"
)

# --------------------------------------
# TIMESERIES SECTION
# --------------------------------------
development_title = Div(text="""<h2 style='color: #3366cc;'>Development of CO2 and GDP over Time by Country</h2>""",
                      width=800, height=50)

# Section placeholder
development_section = column(
    development_title,
    Div(text="""<p style='color: #666666;'>[Exercise: Complete this section]</p>"""),
    sizing_mode="stretch_width"
)

# --------------------------------------
# THE BY YEAR SECTION
# --------------------------------------
# Section title
byyear_title = Div(text="""<h2 style='color: #3366cc;'>CO2 Emissions and GDP by Year</h2>""",
                      width=800, height=30)

# Get min and max years from data
years = sorted(df['year'].unique().tolist())
min_year, max_year = min(years), max(years)

# Create slider
byyear_slider = Slider(
    start=min_year, 
    end=max_year, 
    step=1, 
    value=min_year, 
    title='Year'
)

# Create ColumnDataSource for the scatter plot
source_co2_gdp_byyear = ColumnDataSource(data=dict(
    co2=[], gdp=[], country=[], region=[]
))

# Get unique regions for categorical coloring
all_regions = df['region'].unique().tolist()

# Create a color mapper
regions_color_mapper = CategoricalColorMapper(
    factors=all_regions,
    palette=Category10[len(all_regions)]
)

# Create scatter plot figure
p_co2_gdp_byyear = figure(
    height=400, width=800, sizing_mode="scale_width",
)

# Add a scatterplot
p_co2_gdp_byyear.scatter(source=source_co2_gdp_byyear, x='gdp', y='co2',
          size=10, fill_alpha=0.5,
          color={'field': 'region', 'transform': regions_color_mapper},  # Color by region
          legend_field='region'  # Add legend using region field
        )

# Initialize the title and set formatting
p_co2_gdp_byyear.title = Title(
    text='CO2 Emissions vs GDP in selected year',
)

# Axis labels and formatting
p_co2_gdp_byyear.xaxis.axis_label = "GDP (in USD per capita)"
p_co2_gdp_byyear.xaxis.axis_label_text_font_style = 'normal'
p_co2_gdp_byyear.xaxis.formatter = NumeralTickFormatter(format='0 a')

# Change to log scale for y-axis
p_co2_gdp_byyear.y_scale = LogScale()
p_co2_gdp_byyear.yaxis.ticker = LogTicker()
p_co2_gdp_byyear.yaxis.formatter = LogTickFormatter()
p_co2_gdp_byyear.yaxis.axis_label = "CO2 emissions (metric tons per capita)"
p_co2_gdp_byyear.yaxis.axis_label_text_font_style = 'normal'

# Customize the legend
p_co2_gdp_byyear.legend.title = "Region"
p_co2_gdp_byyear.legend.title_text_font_style = "bold"
p_co2_gdp_byyear.legend.location = "top_right"
p_co2_gdp_byyear.legend.label_text_font_size = "10pt"
p_co2_gdp_byyear.legend.background_fill_alpha = 0.5

# Add hover tool
hover_tool = HoverTool(tooltips=[
    ("Country", "@country"),
    ("Region", "@region"),
    ("CO2", "@co2{0.00}"),
    ("GDP", "@gdp{0,0.00}")
])
p_co2_gdp_byyear.add_tools(hover_tool)

def update_byyear_data(attr, old, new):
    """Update the scatter plot based on the selected year"""
    year = byyear_slider.value

    # Update the plot title to show the selected year
    p_co2_gdp_byyear.title.text = f"GDP vs CO2 Emissions by Country in {year}"
    
    # Get data for the selected year
    year_data = df[df['year'] == year]

    # Extract the data for plotting
    co2_values = year_data['co2'].tolist()
    gdp_values = year_data['gdp'].tolist()
    countries = year_data['country'].tolist()
    regions = year_data['region'].tolist()
    
    # Update the scatter plot data source
    source_co2_gdp_byyear.data = {
        'co2': co2_values,
        'gdp': gdp_values,
        'country': countries,
        'region': regions
    }

# Set up callback for the year slider
byyear_slider.on_change('value', update_byyear_data)

# Initialize the by-year data
update_byyear_data(None, None, None)

# Section placeholder
byyear_section_extension = column(
    Div(text="""<p style='color: #666666;'>[Exercise: Add more graphs that show CO2/GDP for the selected year]</p>"""),
    sizing_mode="stretch_width"
)

# Create the by-year section layout
byyear_section = column(
    byyear_title,
    byyear_slider,
    p_co2_gdp_byyear,
    byyear_section_extension,
    sizing_mode="stretch_width"
)

# --------------------------------------
# THE COMPLETE LAYOUT
# --------------------------------------
# Put everything together
dashboard = column(
    title,
    overview_section,
    co2_section,
    gdp_section,
    development_section,
    byyear_section,
    sizing_mode="stretch_width"
)

# Add the layout to the current document
curdoc().add_root(dashboard)
curdoc().title = "CO2 Emissions Dashboard"