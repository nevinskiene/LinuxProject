FSA = $(wildcard inputs/*.fsa)
OUT = ${FSA:inputs/%.fsa=outputs/%.unfolded}
ORF = ${FSA:inputs/%.fsa=outputs/%.orfs}
GC = ${FSA:inputs/%.fsa=outputs/%.gc}
PNG = ${FSA:inputs/%.fsa=images/%.png}
EPS = ${FSA:inputs/%.fsa=images/%.eps}

all: $(OUT) $(GC) $(PNG) $(EPS) GC_Content_in_yeast.pdf slides_GC_yeast_bozena.pdf
.SUFFIXES:

unfolded: ${OUT}
orfs: ${ORF}
pngs: ${PNG}
eps: ${EPS}
pdf: $(PDF)

outputs/%.unfolded:
	bin/fasta-unfold

outputs/%.orfs: outputs/%.unfolded
	bin/find-orfs $< > $@

outputs/%.gc: outputs/%.orfs
	bin/gc-content $< | tail -n +2 > $@
	rm $<

images/%.png: outputs/%.gc
	bin/plot.R < $< > $@

images/%.eps: images/%.png
	pngtopnm $< | pnmtops > $@
	rm $<

# Tex > PDF

%.dvi: %.tex ${EPS}
	latex $<

%.ps: %.dvi
	dvips $<

%.pdf: %.ps
	ps2pdf $<
