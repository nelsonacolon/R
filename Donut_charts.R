install.packages("ggplot2")
library(ggplot2)

cat <- c("A", "B", "C", "D")
qty <- c(8, 13, 15, 64)

df <- data.frame(cat,qty)

df$fraction <- df$qty/sum(df$qty)

df$ymax <- cumsum(df$fraction)

df$ymin <- c(0, head(df$ymax, n=-1))

df$labelPos <- (df$ymax + df$ymin) / 2

df$label <- paste0(df$cat, "\n value: ", df$qty)

# ggplot (df, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=cat)) +
#   geom_rect() +
#   coord_polar(theta="y") +
#   xlim(c(2,4))

ggplot (df, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=cat)) +
  geom_rect() +
  geom_label(x=3.5, aes(y=labelPos, label=label), size=6) +
  scale_fill_brewer(palette=4) +
  coord_polar(theta="y") +
  xlim(c(2,4)) +
  theme_void() +
  theme(legend.position="none")
