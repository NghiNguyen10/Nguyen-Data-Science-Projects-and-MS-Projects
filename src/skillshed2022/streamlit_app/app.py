import streamlit as st
from CleaningAndTransposing import knowledge_wide, work_activity_wide, work_context_wide, job_zones_2
from CombiningFourDataFiles import skillshed
from EuclideanDistances import occ_list, final_result
from WageTable import oews_wage

tab1, tab2 = st.tabs(['Analysis', 'Downloads'])


with tab1:
    st.title("Skillshed Analysis")

    # Helper Function to View Row and Column Count of a DataFrame
    def row_col_count(df):
        rows, cols = df.shape
        st.text(f"Row Count: {rows}\nColumn Count: {cols}")

    # View Wide DataFrames
    wide_dict = {'KnowledgeWide': knowledge_wide, 'WorkActivity': work_activity_wide, 'WorkContext': work_context_wide, 'JobZones': job_zones_2}

    frame_option = st.selectbox(label="Select a DataFrame: ", options=list(wide_dict.keys()))

    if frame_option != None:
        # Getting the selection as a variable
        wide_df = wide_dict[frame_option]
        st.dataframe(wide_df)
        row_col_count(wide_df)

    # Display Skillshed

    st.markdown("### View Skillshed")

    st.text("The Skillshed dataframe essentially combines the wide dataframes above \n by joining on the SOC_Code.")

    if st.button("View Skillshed"):
        st.dataframe(skillshed)
        row_col_count(skillshed)

    # Display OCC List

    st.markdown("### View OCC List")

    st.text("This DataFrame contains a list of growing and declining jobs \n along with their SOC Codes.")

    if st.button("View OCC List"):
        st.dataframe(occ_list)
        row_col_count(occ_list)

    # Calculate Euclidean Distance
    st.markdown("#### Euclidean Distance Formula ")
    st.markdown("$d(x, y) = \sqrt{\\sum_{i=1}^{n} (x_i - y_i)^2}$")


    if st.button("Calculate Euclidean Distance"):
        st.dataframe(final_result)
        row_col_count(final_result)

    # Calculate Wage
    st.text("This DataFrame contains the wages calculated for growing and declining jobs.")

    if st.button("Calculate Wage"):
        st.dataframe(oews_wage)
        row_col_count(oews_wage)


@st.cache
def convert_df(df):
    return df.to_csv().encode('utf-8')

with tab2:
    st.title("Download Data")
    download_dict = wide_dict
    download_dict['Skillshed'] = skillshed
    download_dict['OCC List'] = occ_list
    download_dict['Distance'] = final_result
    download_dict['Wage'] = oews_wage

    option = st.selectbox(label="Select a DataFrame to download: ", options=list(download_dict.keys()))

    # Download Function
    st.download_button(
        label="Download",
        data= convert_df(download_dict[option]),
        file_name = f"{option}.csv",
        mime='text/csv'
    )