

      HomAltRealCount = HomAltCount - HomAltAllCount, 
                      HomRefPer = HomRefCount/CalledCount,
                      HomAltAllPer = HomAltAllCount/CalledCount,
                      HomAltRealPer = HomAltRealCount/CalledCount,
                      HetPer = HetCount/CalledCount,
                      RefAlleleCount = 2*HomRefCount + HetCount, 
                      AltAlleleCount = 2*HomAltCount + HetCount,
                      TotalAlleleCount = 2*CalledCount,
                      RefAllelePer = RefAlleleCount/TotalAlleleCount, 
                      AltAllelePer = AltAlleleCount/TotalAlleleCount,



pp3 <- ggplot(data = forbarplot,
              aes(x = SampleId, y = value, fill = variable)) +
    geom_bar(position="stack", stat="identity") + 
    facet_wrap(. ~ MutType) + 
    scale_fill_brewer(palette = "Greys") + 
    geom_vline(xintercept = 28.5, color = "#377EB8") + 
    labs(y = "Proportion", fill = "Variant Types") + 
    theme_bw() + 
    theme(axis.text.x = element_text(angle = 90)) 
ggsave(filename = "syn_mis_lof_proportion_all48_canonical_CDS.pdf", plot = pp3, path = plotdir, height = 6, width = 18)


