library(ggseg)
library(ggplot2)
library(dplyr)
library(gridExtra)
library(grid)

# https://colorbrewer2.org/#type=diverging&scheme=PRGn&n=4  (kinda, actually cribbed from the "Pick a color scheme" pallette
colors = c("#008837", "#47B250", "#7FBF7B", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#AF8DC3", "#9463A5", "#7B3294")


h_thick_data <- read.csv("thk_correlations_output.csv")
h_thick_data <- h_thick_data[h_thick_data$OCP == 'OCP_1', ]

h_thick_style <- ggplot(h_thick_data) +
                 theme_brain2() +
                 theme(legend.frame=element_rect(colour="black")) +
                 scale_fill_stepsn(n.breaks=9, colours=colors, limits=c(-.35, .35)) +
               theme(legend.title=element_blank())

thick_dhea_plot <- h_thick_style + geom_brain(atlas=dk, mapping=aes(fill=r_dhea))
thick_ert_plot <- h_thick_style + geom_brain(atlas=dk, mapping=aes(fill=r_ert))
thick_hse_plot <- h_thick_style + geom_brain(atlas=dk, mapping=aes(fill=r_hse))

h_vol_data <- read.csv("Volume_correlations.csv")
h_vol_data <- h_vol_data[h_vol_data$OCP == 'OCP_1', ]
h_vol_style <- ggplot(h_vol_data) +
               theme_brain2() +
               theme(legend.frame=element_rect(colour="black")) +
                 scale_fill_stepsn(n.breaks=9, colours=colors, limits=c(-.35, .35)) +
               theme(legend.title=element_blank())

vol_dhea_plot <- h_vol_style + geom_brain(atlas=dk, mapping=aes(fill=r_dhea))
vol_ert_plot <- h_vol_style + geom_brain(atlas=dk, mapping=aes(fill=r_ert))
vol_hse_plot <- h_vol_style + geom_brain(atlas=dk, mapping=aes(fill=r_hse))

h_area_data <- read.csv("area_correlations_output_fixed.csv")
h_area_data <- h_area_data[h_area_data$OCP == 'OCP_1', ]
h_area_style <- ggplot(h_area_data) +
                theme_brain2() +
                theme(legend.frame=element_rect(colour="black")) +
                 scale_fill_stepsn(n.breaks=9, colours=colors, limits=c(-.35, .35)) +
               theme(legend.title=element_blank())

area_dhea_plot <- h_area_style + geom_brain(atlas=dk, mapping=aes(fill=r_dhea))
area_ert_plot <- h_area_style + geom_brain(atlas=dk, mapping=aes(fill=r_ert))
area_hse_plot <- h_area_style + geom_brain(atlas=dk, mapping=aes(fill=r_hse))

empty_grob <- textGrob("")

thick_title <- textGrob("Cortical Thickness", just="bottom", gp=gpar(fontsize=20))
vol_title <- textGrob("Volume", just="bottom", gp=gpar(fontsize=20))
area_title <- textGrob("Area", just="bottom", gp=gpar(fontsize=20))

dhea_title <- textGrob("DHEA", just="right", gp=gpar(fontsize=20))
ert_title <- textGrob("ERT", just="right", gp=gpar(fontsize=20))
hse_title <- textGrob("HSE", just="right", gp=gpar(fontsize=20))

grid.arrange( empty_grob,     thick_title,     area_title,     vol_title,
              dhea_title, thick_dhea_plot, area_dhea_plot, vol_dhea_plot,
              ert_title,  thick_ert_plot,  area_ert_plot,  vol_ert_plot,
              hse_title,  thick_hse_plot,  area_hse_plot,  vol_hse_plot,
             ncol=4, widths=c(85, 350, 350, 350), heights=c(24, 100, 100, 100))

g <- arrangeGrob( empty_grob,     thick_title,     area_title,     vol_title,
                  dhea_title, thick_dhea_plot, area_dhea_plot, vol_dhea_plot,
                  ert_title,  thick_ert_plot,  area_ert_plot,  vol_ert_plot,
                  hse_title,  thick_hse_plot,  area_hse_plot,  vol_hse_plot,
                 ncol=4, widths=c(85, 350, 350, 350), heights=c(24, 100, 100, 100))

ggsave(file="OCP_1.png", g, width=6000, height=1650, units=c("px"))

