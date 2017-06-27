ups <-
  read.delim(
    "CDF.txt"
  )
p <-
  ggplot(data = ups, aes(x = value)) + stat_ecdf(aes(colour = type), size =
                                                   2) + scale_color_manual(values = c("#FFA500", "#3A5FCD", "#EE2C2C")) +
  labs(x = 'Coding Probablity(CPAT)', title = "Coding Potential", y = "CDF")
p + theme(
  panel.background = element_rect(
    fill = "transparent",
    colour = "black",
    size = 1.3
  ),
  plot.title = element_text(hjust = 0.5, face = "bold", size = 20),
  axis.title.x = element_text(
    colour = "black",
    face = "bold",
    size = 14
  ),
  axis.title.y = element_text(
    colour = "black",
    face = "bold",
    size = 14
  ),
  axis.text.x = element_text(colour = "black", face = "bold"),
  axis.text.y = element_text(colour = "black", face = "bold")
)

p + theme_bw()
#p+theme(panel.background = element_rect(),axis.line.x=element_line(linetype=1,color="black",size=1),axis.line.y=element_line(linetype=1,color="black",size=1))
#p+theme_bw()+theme(panel.border = element_blank(),panel.grid.major = element_blank(),panel.grid.minor = element_blank(),panel.background = element_rect(),axis.line.x=element_line(linetype=1,color="black",size=1),axis.line.y=element_line(linetype=1,color="black",size=1))
p + geom_hline(
  yintercept = c(0, 1),
  colour = "grey",
  linetype = "dashed",
  size = 1
)

