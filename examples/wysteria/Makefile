include ../Makefile.include

all:
	make api
	make theory
	make codegen SMCIF=examples/fstar_main/milliface.fsi SMCMAIN=examples/fstar_main/millmain.fst
	make distclean

EXAMPLES_DIR=./examples

api:
	make -C examples api FSTAR='../$(FSTAR)'

theory:
	$(FSTAR) theory.fst

OUTPUT_DIR=./ocaml-output

CONTRIB=$(FSTAR_HOME)/contrib

CODEGEN_FLAGS=--admit_fsi FStar.Set --admit_fsi FStar.String --admit_fsi FStar.Seq --admit_fsi Ffibridge --admit_fsi Runtime --admit_fsi Prog --admit_fsi FStar.IO\
              --admit_fsi FStar.Squash --admit_fsi Smciface --codegen-lib Platform --codegen-lib CoreCrypto --codegen OCaml --odir $(OUTPUT_DIR)\
              --use_native_int --__temp_no_proj PSemantics --__temp_no_proj SecServer

FSTAR_LIB_FILES=classical.fst ext.fst set.fsi heap.fst st.fst all.fst seq.fsi seqproperties.fst ghost.fst squash.fsti\
                listTot.fst list.fst listproperties.fst ordset.fsi ordset.fst ordmap.fsi ordmap.fst io.fsti string.fsi\

INTERPRETER_FILES=prins.fst ast.fst ffibridge.fsi sem.fst psem.fst rtheory.fst $(CONTRIB)/Platform/fst/Bytes.fst\
                  runtime.fsi print.fst ckt.fst $(CONTRIB)/CoreCrypto/fst/CoreCrypto.fst ../crypto/sha1.fst crypto.fst\
                  interpreter.fst sec_server.fst examples/ffi.fst prog.fsi

#SMCIF and SMCMain are set from command line invocation of make
codegen:
	cp $(SMCIF) smciface.fsi
	cp $(SMCMAIN) smc_main.fst
	$(FSTAR) $(CODEGEN_FLAGS) $(EXTERNAL_FLAGS) $(FSTAR_LIB_FILES) $(INTERPRETER_FILES) smciface.fsi smc_main.fst

# codegen:
# 	$(FSTAR) --admit_fsi FStar.Set --admit_fsi FStar.String --admit_fsi FStar.Seq --admit_fsi Ffibridge --admit_fsi Runtime --admit_fsi Prog --admit_fsi FStar.IO --admit_fsi FStar.Squash\
#                  --codegen-lib Platform --codegen-lib CoreCrypto --codegen OCaml --odir $(OUTPUT_DIR) --use_native_int --__temp_no_proj PSemantics --__temp_no_proj SecServer\
#                  classical.fst ext.fst set.fsi heap.fst st.fst all.fst seq.fsi seqproperties.fst ghost.fst squash.fsti\
#                  listTot.fst list.fst listproperties.fst ordset.fsi ordset.fst ordmap.fsi ordmap.fst io.fsti string.fsi\
#                  prins.fst ast.fst ffibridge.fsi sem.fst psem.fst rtheory.fst $(CONTRIB)/Platform/fst/Bytes.fst runtime.fsi print.fst ckt.fst $(CONTRIB)/CoreCrypto/fst/CoreCrypto.fst ../crypto/sha1.fst crypto.fst interpreter.fst sec_server.fst examples/ffi.fst prog.fsi main.fst 

a.out:
	make -C $(OUTPUT_DIR) a.out

clean:
	make -C $(OUTPUT_DIR) clean

distclean:
	rm -f smciface.fsi smc_main.fst
	make -C $(OUTPUT_DIR) distclean
