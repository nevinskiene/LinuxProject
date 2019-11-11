FSA = $(wildcard inputs/*.fsa)
OUT = ${FSA:inputs/%.fsa=outputs/%.unfolded}
ORF = ${FSA:inputs/%.fsa=outputs/%.orfs}
GC = ${FSA:inputs/%.fsa=outputs/%.gc}
PNG = ${FSA:inputs/%.fsa=images/%.png}

all: $(OUT) $(ORF) $(GC) $(PNG)
unfolded: ${OUT}
orfs: ${ORF}
pngs: ${PNG}

outputs/%.unfolded:
	bin/fasta-unfold

outputs/%.orfs: outputs/%.unfolded
	bin/find-orfs $< > $@

outputs/%.gc: outputs/%.orfs
	bin/gc-content $< | tail -n +2 > $@
	rm $<

images/%.png: outputs/%.gc
	bin/plot.R < $< > $@
