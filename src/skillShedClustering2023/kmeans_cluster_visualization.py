import numpy as np
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D
from KMC_MD_TestRun import results, kmc_md
from scipy.spatial import ConvexHull
from scipy import interpolate

def prepare_visual_data(df, kmc_md):
    # Want to centers x and y
    centers = kmc_md.centers

    cen_x = [i[0] for i in centers]
    cen_y = [i[1] for i in centers]

    df['cen_x'] = df['cluster_labels'].map({i: cen_x[i] for i in df['cluster_labels'].unique()})
    df['cen_y'] = df['cluster_labels'].map({i: cen_y[i] for i in df['cluster_labels'].unique()})

    # Define colors
    colors = ['#DF2020', '#81DF20', '#2095DF']

    # Create color scheme
    df['c'] = df['cluster_labels'].map({i : colors[i] for i in range(len(colors))})

    return df, colors, cen_x, cen_y

def create_scatter(df, colors):
    plt.figure(figsize=(10,10))
    plt.scatter(df['comp-1'], df['comp-2'], c=df['c'], alpha=0.6, s=40)
    plt.title("Scattering of Cluster Points", size=16)
    plt.xlabel(f'Component 1 (n = {kmc_md.df.shape[1]})', size=12)
    plt.ylabel(f'Component 2 (n = {kmc_md.df.shape[1]})', size=12)
    label_handles = [Line2D([0], [0], marker='o', color='w', label=f'Cluster {i+1}',
                    markerfacecolor=mcolor, markersize=5) for i,
                    mcolor in enumerate(colors)]
    plt.legend(handles=label_handles, loc='upper right')
    plt.show()

def create_contour_plot(df, colors, cen_x, cen_y):
    
    # Figure
    plt.figure(figsize=(10,10))

    # Title for figure
    plt.title("K Means Contour Plot", size=16)

    # Scatter components
    plt.scatter(df['comp-1'], df['comp-2'], c=df.c, alpha=0.6, s=40)

    # Scattering the centers for both components
    plt.scatter(cen_x, cen_y, marker='^', c=colors, s=70)

    # Go through each cluster and build convex hulls
    for i in df['cluster_labels'].unique():
        # Get the Convex Hull
        points = df[df['cluster_labels'] == i][['comp-1', 'comp-2']].values
        hull = ConvexHull(points)

        x_hull = np.append(points[hull.vertices, 0],
                            points[hull.vertices, 0][0])
        
        y_hull = np.append(points[hull.vertices, 1],
                            points[hull.vertices, 1][0])
        
        # Interpolation
        dist = np.sqrt((x_hull[:-1] - x_hull[1:])**2 + (y_hull[:-1] - y_hull[1:])**2)
        dist_along = np.concatenate(([0], dist.cumsum()))
        spline, u = interpolate.splprep([x_hull, y_hull], u=dist_along, s=0, per=1)
        interp_d = np.linspace(dist_along[0], dist_along[-1], 50)
        interp_x, interp_y = interpolate.splev(interp_d, spline)

        # Plot Shape
        plt.fill(interp_x, interp_y, '--', c=colors[i], alpha=0.2)
    
    plt.show()



result_df, colors, cen_x, cen_y = prepare_visual_data(results, kmc_md)

# create_scatter(result_df, colors)

create_contour_plot(result_df, colors, cen_x, cen_y)


