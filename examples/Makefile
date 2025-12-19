all: dragon.pdf pex_3j.pdf tutorial.pdf

%.pdf: %.typ
	typst compile $< --root ..

clean:
	rm *.pdf
