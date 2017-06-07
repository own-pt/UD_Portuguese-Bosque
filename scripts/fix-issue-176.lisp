(ql:quickload :cl-conllu)
(ql:quickload :cl-utilities)
(in-package :cl-conllu)

(defparameter table '(("A_bordo" "" "ADV" "ADP NOUN")
		     ("a_bordo" "" "ADV" "ADP NOUN")
		     ("a_bordo_de" "" "ADP" "ADP NOUN ADP")
		     ("a_exemplo" "a_exemplo_de" "ADP" "ADP NOUN ADP")
		     ("a_custo" "" "ADV" "ADP NOUN")
		     ("A_descoberto" "" "ADV" "ADP NOUN")
		     ("a_eito" "" "ADV" "ADP NOUN")
		     ("a_fundo" "" "ADV" "ADP NOUN")
		     ("a_horas" "" "ADV" "ADP NOUN")
		     ("a_favor" "" "ADV" "ADP NOUN")
		     ("a_favor_de" "" "ADP" "ADP NOUN ADP")
		     ("a_breve_prazo" "ELIMINAR" "" "ADP ADJ NOUN")
		     ("a_breve_trecho" "" "ADV" "ADP ADJ NOUN")
		     ("A_bem_dizer" "" "ADV" "ADP ADV VERB")
		     ("a_cargo_de" "" "ADP" "ADP NOUN ADP")
		     ("a_céu_aberto" "" "ADV" "ADP NOUN VERB")
		     ("a_coberto_de" "" "ADP" "ADP VERB ADP")
		     ("A_criação" "ELIMINAR" "" "DET NOUN")
		     ("a_favor_ou_contra"
		      "ELIMINAR: deve ser --> a_favor (ADV) ou (CCONJ) contra(ADP)" ""
		      "ADP NOUN CCONJ ADP")
		     ("a_ferro_e_fogo" "" "ADV" "ADP NOUN CCONJ NOUN")
		     ("a_fim_de" "" "ADP" "ADP NOUN ADP")
		     ("a_fim_de_que" "" "SCONJ" "ADP NOUN ADP SCONJ")
		     ("a_longo_prazo" "" "ADV" "ADP ADJ NOUN")
		     ("a_mais_de" "" "ADP" "ADP ADV ADP")
		     ("a_mal" "" "ADV" "ADP ADV")
		     ("À_maneira_de" "" "ADP" "ADP DET NOUN ADP")
		     ("À_medida_que" "" "SCONJ" "ADP DET NOUN SCONJ")
		     ("a_meu_ver" "" "ADV" "ADP PRON VERB")
		     ("A_não_ser_que" "" "SCONJ" "ADP ADV VERB SCONJ")
		     ("a_não_ser_que" "" "SCONJ" "ADP ADV VERB SCONJ")
		     ("a_par" "" "ADV" "ADP NOUN") ("A_par_de" "" "ADP" "ADP NOUN ADP")
		     ("a_par_de" "" "ADP" "ADP NOUN ADP") ("A_partir_de" "" "ADP" "ADP VERB ADP")
		     ("a_partir_de" "" "ADP" "ADP VERB ADP") ("a_pé" "" "ADV" "ADP NOUN")
		     ("a_pedido" "a_pedido_de" "ADP" "ADP NOUN ADP")
		     ("a_ponto_de" "a_ponto_de" "ADP" "ADP NOUN ADP")
		     ("a_posteriori" "" "ADV" "ADP NOUN") ("a_postos" "" "ADV" "ADP NOUN")
		     ("a_preceito" "" "ADV" "ADP NOUN")
		     ("À_primeira_vista" "" "ADV" "ADP DET ADJ NOUN")
		     ("a_priori" "" "ADV" "ADP NOUN") ("A_propósito" "" "ADV" "ADP NOUN")
		     ("A_propósito_de" "" "ADP" "ADP NOUN ADP")
		     ("a_propósito_de" "" "ADP" "ADP NOUN ADP") ("a_qual" "" "PRON" "PRON PRON")
		     ("a_respeito_de" "" "ADP" "ADP NOUN ADP") ("a_rigor" "" "ADV" "ADP NOUN")
		     ("a_salvo" "" "ADV" "ADP ADJ") ("a_seguir" "" "ADV" "ADP VERB")
		     ("a_sério" "" "ADV" "ADP ADJ") ("a_seu_modo" "" "ADV" "ADP PRON NOUN")
		     ("a_tempo" "" "ADV" "ADP NOUN") ("a_tempo_de" "" "ADP" "ADP NOUN ADP")
		     ("A_título_de" "" "ADP" "ADP NOUN ADP")
		     ("a_título_de" "" "ADP" "ADP NOUN ADP") ("a_toda_a" "a_toda" "ADV" "ADP PRON")
		     ("a_todo_o_pano" "" "ADV" "ADP PRON DET NOUN")
		     ("abaixo_de" "" "ADP" "ADV ADP") ("acerca_de" "" "ADP" "ADV ADP")
		     ("acima_de" "" "ADP" "ADV ADP") ("agora_que" "" "SCONJ" "ADV SCONJ")
		     ("Ah_bem" "" "INTJ" "INTJ ADV") ("Ainda_assim" "" "CCONJ" "ADV CCONJ")
		     ("ainda_assim" "" "CCONJ" "ADV CCONJ") ("ainda_bem" "" "ADV" "ADV ADV")
		     ("Ainda_por_cima" "" "ADV" "ADV ADP NOUN")
		     ("Ainda_que" "" "SCONJ" "ADV SCONJ") ("ainda_que" "" "SCONJ" "ADV SCONJ")
		     ("Além_de" "" "ADP" "ADV ADP") ("além_de" "" "ADP" "ADV ADP")
		     ("Ao_contrário" "" "ADV" "ADP DET NOUN")
		     ("Ao_contrário_de" "" "ADP" "ADP DET NOUN ADP")
		     ("Ao_lado_de" "" "ADP" "ADP DET NOUN ADP")
		     ("Ao_longo_de" "" "ADP" "ADP DET NOUN ADP")
		     ("Ao_mesmo_tempo" "" "ADV" "ADP DET ADJ NOUN")
		     ("Ao_todo" "" "ADV" "ADP DET PRON") ("Ao_vivo" "" "ADV" "ADP DET NOUN")
		     ("Aos_trancos_e_barrancos" "" "ADV" "ADP DET NOUN CCONJ NOUN")
		     ("Apesar_de" "" "ADP" "ADV ADP") ("apesar_de" "" "ADP" "ADV ADP")
		     ("Apesar_disso" "" "CCONJ" "ADV ADP PRON")
		     ("apesar_disso" "" "CCONJ" "ADV ADP PRON") ("aquando_de" "" "ADP" "ADV ADP")
		     ("aquém_de" "" "ADP" "ADV ADP") ("aqui_e_ali" "" "ADV" "ADV CCONJ ADV")
		     ("as_quais" "" "PRON" "PRON PRON") ("Às_vezes" "" "ADV" "ADP DET NOUN")
		     ("Assim_como" "" "SCONJ" "ADV SCONJ") ("até_então" "" "ADV" "ADV ADV")
		     ("até_mesmo" "" "ADV" "ADV ADJ") ("até_que_ponto" "" "SCONJ" "ADV SCONJ NOUN")
		     ("Atrás_de" "" "ADP" "ADV ADP") ("atrás_de" "" "ADP" "ADV ADP")
		     ("através_de" "" "ADP" "ADV ADP") ("bem_como" "" "CCONJ" "ADV CCONJ")
		     ("cada_qual" "" "PRON" "PRON PRON") ("cada_um" "" "PRON" "PRON PRON")
		     ("cada_vez" "" "ADV" "PRON NOUN")
		     ("cada_vez_mais" "cada_vez" "ADV" "PRON NOUN") ("Cerca_de" "" "ADP" "ADV ADP")
		     ("com_antecedência" "ELIMINAR" "" "ADP NOUN")
		     ("com_base_em" "" "ADP" "ADP NOUN ADP")
		     ("com_bons_olhos" "" "ADV" "ADP ADJ NOUN")
		     ("com_distinção" "" "ADV" "ADP NOUN") ("Com_efeito" "" "ADV" "ADP NOUN")
		     ("com_efeito" "" "ADV" "ADP NOUN") ("com_relação_a" "" "ADP" "ADP NOUN ADP")
		     ("com_tempo" "" "ADV" "ADP NOUN") ("com_vista_a" "" "ADP" "ADP NOUN ADP")
		     ("com_vontade" "" "ADV" "ADP NOUN") ("Como_que" "" "SCONJ" "ADV PRON")
		     ("como_que" "" "SCONJ" "ADV PRON") ("como_se" "" "SCONJ" "SCONJ SCONJ")
		     ("como_também" "" "CCONJ" "CCONJ ADV") ("dado_que" "" "SCONJ" "ADJ SCONJ")
		     ("dali_para_diante" "" "ADV" "PREP ADV ADP ADV")
		     ("De_acordo" "De_acordo_com" "ADP" "ADP NOUN ADP")
		     ("de_acordo" "" "ADJ" "ADP NOUN")
		     ("de_agora" "de_agora_em_diante" "ADV" "ADP ADV ADP ADV")
		     ("de_agora_em_diante" "" "ADV" "ADP ADV ADP ADV")
		     ("de_antemão" "" "ADV" "ADP ADV") ("de_cima" "" "ADV" "ADP NOUN")
		     ("de_comprimento" "ELIMINAR" "" "ADP NOUN")
		     ("de_conta" "ELIMINAR" "" "ADP NOUN") ("de_destaque" "ELIMINAR" "" "ADP NOUN")
		     ("de_dia" "ELIMINAR" "" "ADP NOUN") ("de_direito" "" "ADJ" "ADP NOUN")
		     ("de_encontro_a" "" "ADP" "ADP NOUN ADP")
		     ("de_estilo" "ELIMINAR" "" "ADP NOUN") ("de_estudo" "ELIMINAR" "" "ADP NOUN")
		     ("de_fachada" "" "ADJ" "ADP NOUN") ("De_facto" "" "ADV" "ADP NOUN")
		     ("de_facto" "" "ADV" "ADP NOUN") ("De_fato" "" "ADV" "ADP NOUN")
		     ("de_fato" "" "ADV" "ADP NOUN") ("de_fora" "" "ADV" "ADP ADV")
		     ("de_fora_de" "ELIMINAR" "" "ADP ADV ADP")
		     ("de_forma_a" "" "ADP" "ADP NOUN ADP")
		     ("de_graça" "estado_de_graça" "ADJ" "NOUN ADP NOUN")
		     ("de_hoje_em_diante" "" "ADV" "ADP ADV ADP ADV")
		     ("de_imediato" "" "ADV" "ADP ADV") ("de_la_Peña" "ELIMINAR" "" "PROPN")
		     ("de_lei" "ELIMINAR" "" "ADP NOUN") ("de_longe" "" "ADV" "ADP ADV")
		     ("de_madrugada" "ELIMINAR" "" "ADP ADV")
		     ("de_maneira_a" "" "ADP" "ADP NOUN ADP") ("de_manhã" "ELIMINAR" "" "ADP NOUN")
		     ("de_marca" "ELIMINAR" "" "ADP NOUN") ("de_modo_a" "" "ADP" "ADP NOUN ADP")
		     ("de_modo_algum" "" "ADV" "ADP NOUN PRON")
		     ("de_modo_que" "" "SCONJ" "ADP NOUN SCONJ")
		     ("de_noite" "ELIMINAR" "" "ADP NOUN") ("de_novo" "" "ADV" "ADP ADJ")
		     ("de_outro_lado" "ELIMINAR" "" "ADP PRON NOUN")
		     ("de_outro_modo" "" "ADV" "ADP PRON NOUN") ("de_pé" "" "ADV" "ADP NOUN")
		     ("de_perto" "" "ADV" "ADP NOUN") ("de_peso" "" "ADJ" "ADP NOUN")
		     ("de_prata" "ELIMINAR" "" "ADP NOUN") ("de_preferência" "" "ADV" "ADP NOUN")
		     ("de_profissão" "ELIMINAR" "" "ADP NOUN") ("de_propósito" "" "ADV" "ADP NOUN")
		     ("de_qualquer_maneira" "" "ADV" "ADP PRON NOUN")
		     ("De_qualquer_modo" "" "ADV" "ADP PRON NOUN")
		     ("de_quebra" "" "ADV" "ADP NOUN") ("de_raiz" "ELIMINAR" "" "ADP NOUN")
		     ("de_rastos" "" "ADJ" "ADP NOUN") ("de_repetição" "ELIMINAR" "" "ADP NOUN")
		     ("De_resto" "" "CCONJ" "ADP NOUN") ("de_resto" "" "CCONJ" "ADP NOUN")
		     ("de_seguida" "ELIMINAR" "" "ADP NOUN") ("De_súbito" "" "ADV" "ADP NOUN")
		     ("de_súbito" "" "ADV" "ADP NOUN") ("de_surpresa" "" "ADV" "ADP NOUN")
		     ("de_tal_forma" "de_tal_forma_que" "SCONJ" "ADP PRON NOUN SCONJ")
		     ("de_tal_modo_que" "" "SCONJ" "ADP PRON NOUN SCONJ")
		     ("de_topo" "ELIMINAR" "" "ADP NOUN") ("de_trás" "" "ADV" "ADP ADV")
		     ("De_um_lado" "" "ADV" "ADP DET NOUN") ("de_um_lado" "" "ADV" "ADP DET NOUN")
		     ("de_urgência" "ELIMINAR" "" "ADP NOUN") ("de_vez" "" "ADV" "ADP NOUN")
		     ("de_vez_em_quando" "" "ADV" "ADP NOUN ADP ADV")
		     ("De_volta" "" "ADV" "ADP NOUN") ("de_volta" "" "ADV" "ADP NOUN")
		     ("debaixo_de" "" "ADP" "ADV ADP") ("Dentro_de" "" "ADP" "ADV ADP")
		     ("dentro_de" "" "ADP" "ADV ADP") ("Desde_então" "" "ADV" "ADP ADV")
		     ("desde_então" "" "ADV" "ADP ADV") ("Desde_há" "ELIMINAR" "" "ADP VERB")
		     ("desde_há" "ELIMINAR" "" "ADP VERB") ("desde_já" "" "ADV" "ADP ADV")
		     ("Desde_logo" "" "ADV" "ADP ADV") ("desde_logo" "" "ADV" "ADP ADV")
		     ("desde_pequeno" "ELIMINAR" "" "ADP ADJ") ("Desde_que" "" "SCONJ" "ADP SCONJ")
		     ("desde_que" "" "SCONJ" "ADP SCONJ") ("Desta_feita" "" "ADV" "ADP PRON NOUN")
		     ("Desta_forma" "" "ADV" "ADP PRON NOUN")
		     ("Desta_vez" "ELIMINAR" "" "ADP PRON NOUN") ("Detrás_de" "" "ADP" "ADV ADP")
		     ("Devido_a" "" "ADP" "ADJ ADP") ("devido_a" "" "ADP" "ADJ ADP")
		     ("diante_de" "" "ADP" "ADV ADP") ("do_que" "ELIMINAR" "" "ADP DET PRON")
		     ("e_assim_por_diante" "" "CCONJ" "CCONJ ADV ADP ADV")
		     ("e_por_aí" "" "CCONJ" "CCONJ ADP ADV") ("É_que" "ELIMINAR" "" "VERB PRON")
		     ("é_que" "ELIMINAR" "" "VERB PRON") ("Eis_que" "" "CCONJ" "ADV CCONJ")
		     ("eis_que" "" "CCONJ" "ADV CCONJ")
		     ("Em_abono_de" "ELIMINAR" "" "ADP NOUN ADP") ("em_bloco" "" "ADV" "ADP NOUN")
		     ("em_breve" "" "ADV" "ADP ADJ")
		     ("Em_carne_e_osso" "" "ADV" "ADP NOUN CCONJ NOUN")
		     ("em_casa" "ELIMINAR" "" "ADP NOUN") ("Em_causa" "" "ADV" "ADP NOUN")
		     ("em_causa" "" "ADV" "ADP NOUN") ("em_cima" "" "ADV" "ADP NOUN")
		     ("Em_cima_de" "" "ADP" "ADP NOUN ADP") ("em_cima_de" "" "ADP" "ADP NOUN ADP")
		     ("em_conjunto" "" "ADV" "ADP NOUN") ("em_conta" "" "ADV" "ADP NOUN")
		     ("Em_contrapartida" "" "CCONJ" "ADP NOUN")
		     ("em_contrapartida" "" "CCONJ" "ADP NOUN") ("em_curso" "" "ADV" "ADP NOUN")
		     ("Em_debate" "" "ADV" "ADP NOUN") ("em_debate" "" "ADV" "ADP NOUN")
		     ("em_detrimento_de" "" "ADP" "ADP NOUN ADP")
		     ("em_diante" "de_agora_em_diante" "ADV" "ADP ADV ADP ADV")
		     ("em_dinheiro" "ELIMINAR" "" "ADP NOUN")
		     ("em_direção_a" "" "ADP" "ADP NOUN ADP")
		     ("em_dois_tempos" "" "ADV" "ADP NUM NOUN")
		     ("em_face_de" "" "ADP" "ADP NOUN ADP") ("em_favor_de" "" "ADP" "ADP NOUN ADP")
		     ("em_flagrante" "" "ADV" "ADP NOUN") ("em_força" "ELIMINAR" "" "")
		     ("em_frente" "" "ADV" "ADP NOUN") ("em_função_de" "" "ADP" "ADP NOUN ADP")
		     ("em_geral" "" "ADV" "ADP NOUN") ("em_grande_parte" "" "ADV" "ADP ADJ NOUN")
		     ("em_homenagem_a" "" "ADP" "ADP NOUN ADP")
		     ("em_jeito_de" "" "ADP" "ADP NOUN ADP")
		     ("em_larga_escala" "" "ADV" "ADP ADJ NOUN") ("em_massa" "" "ADV" "ADP NOUN")
		     ("em_nome_de" "" "ADP" "ADP NOUN ADP")
		     ("em_obediência_a" "" "ADP" "ADP NOUN ADP") ("em_parte" "" "ADV" "ADP NOUN")
		     ("Em_particular" "" "ADP" "ADP NOUN") ("em_particular" "" "ADP" "ADP NOUN")
		     ("em_pé" "" "ADJ" "ADP NOUN")
		     ("em_pé_de" "em_pé_de_igualdade" "ADV" "ADP NOUN ADP NOUN")
		     ("Em_primeiro_lugar" "" "ADV" "ADP NUM NOUN")
		     ("em_primeiro_lugar" "" "ADV" "ADP NUM NOUN")
		     ("Em_princípio" "" "ADV" "ADP NOUN") ("em_princípio" "" "ADV" "ADP NOUN")
		     ("Em_prol_de" "" "ADP" "ADP NOUN ADP") ("em_público" "" "ADV" "ADP NOUN")
		     ("em_questão" "" "ADP" "ADP NOUN ADP") ("em_razão_de" "" "ADP" "ADP NOUN ADP")
		     ("Em_relação_a" "" "ADP" "ADP NOUN ADP")
		     ("em_relação_a" "" "ADP" "ADP NOUN ADP") ("Em_seguida" "" "ADV" "ADP NOUN")
		     ("em_seguida" "" "ADV" "ADP NOUN")
		     ("Em_segundo_lugar" "" "ADV" "ADP NUM NOUN")
		     ("em_segundo_lugar" "" "ADV" "ADP NUM NOUN") ("em_si" "" "ADV" "ADP PRON")
		     ("Em_suma" "" "ADV" "ADP NOUN") ("em_suma" "" "ADV" "ADP NOUN")
		     ("Em_termos" "" "ADV" "ADP NOUN") ("em_termos" "" "ADV" "ADP NOUN")
		     ("Em_termos_de" "" "ADP" "ADP NOUN ADP")
		     ("em_termos_de" "" "ADP" "ADP NOUN ADP") ("em_tese" "" "ADV" "ADP NOUN")
		     ("Em_torno_de" "" "ADP" "ADP NOUN ADP")
		     ("em_torno_de" "" "ADP" "ADP NOUN ADP") ("Em_troca" "" "ADV" "ADP NOUN")
		     ("em_troca" "" "ADV" "ADP NOUN") ("Em_verdade" "ELIMINAR" "" "ADP NOUN")
		     ("Em_vez_de" "" "ADP" "ADP NOUN ADP") ("em_vez_de" "" "ADP" "ADP NOUN ADP")
		     ("em_vias_de" "" "ADP" "ADP NOUN ADP") ("em_vigor" "" "ADV" "ADP NOUN")
		     ("Enquanto_que" "" "SCONJ" "ADV SCONJ") ("entre_si" "ELIMINAR" "" "ADP PRON")
		     ("Face_a" "" "ADP" "NOUN ADP") ("face_a" "" "ADP" "NOUN ADP")
		     ("Fora_de" "ELIMINAR" "" "ADV ADP") ("fora_de" "ELIMINAR" "" "ADV ADP")
		     ("frente_a" "" "ADP" "NOUN ADP") ("graças_a" "ELIMINAR" "" "NOUN ADP")
		     ("hoje_em_dia" "" "ADV" "NOUN ADP NOUN") ("isto_é" "" "CCONJ" "PRON VERB")
		     ("já_não" "ELIMINAR" "" "ADV ADV") ("já_que" "" "SCONJ" "ADV SCONJ")
		     ("logo_a_seguir" "" "ADV" "ADV ADP VERB") ("logo_que" "" "SCONJ" "ADV SCONJ")
		     ("longe_de" "ELIMINAR" "" "ADV ADP") ("Mais_de" "ELIMINAR" "" "ADV ADP")
		     ("mais_de" "ELIMINAR" "" "ADV ADP") ("mais_nada" "" "ADV" "ADV PRON")
		     ("mais_ou_menos" "" "ADV" "ADV CCONJ ADV")
		     ("Mais_uma_vez" "" "ADV" "ADV NUM NOUN")
		     ("mais_uma_vez" "" "ADV" "ADV NUM NOUN") ("menos_de" "ELIMINAR" "" "ADV ADP")
		     ("Mesmo_assim" "" "ADV" "ADJ ADV") ("mesmo_assim" "" "ADV" "ADJ ADV")
		     ("mesmo_que" "" "SCONJ" "ADV SCONJ") ("Meu_Deus" "" "INTJ" "PRON PROPN")
		     ("muitas_vezes" "" "ADV" "ADV NOUN") ("muito_tempo" "ELIMINAR" "" "ADV NOUN")
		     ("Na_melhor_das_hipóteses" "" "ADV" "ADP DET ADJ ADP DET NOUN")
		     ("Nada_do_que" "" "PRON" "PRON ADP DET PRON")
		     ("nada_mais_nada_menos" "" "ADV" "PRON ADV PRON ADV")
		     ("Nada_mal" "" "ADV" "ADV ADV") ("Não_obstante" "" "CCONJ" "ADV ADJ")
		     ("Não_só" "" "ADV" "ADV ADV") ("não_só" "" "ADV" "ADV ADV")
		     ("nem_mesmo" "" "ADV" "ADV ADV") ("Nem_sequer" "" "ADV" "ADV ADV")
		     ("nem_sequer" "" "ADV" "ADV ADV") ("Nessa_altura" "" "ADV" "PRON NOUN")
		     ("No_caso_de" "" "ADP" "ADP DET NOUN ADP")
		     ("No_decurso_de" "" "ADP" "ADP DET NOUN ADP")
		     ("No_entanto" "" "CCONJ" "ADP DET CCONJ")
		     ("No_que_se_refere" "No_que_se_refere_a" "ADP" "ADP DET PRON PRON VERB ADP")
		     ("Nos_termos_de" "" "ADP" "ADP DET NOUN ADP")
		     ("o_futuro_?" "ELIMINAR" "" "DET NOUN PUNCT")
		     ("o_máximo" "ELIMINAR" "" "DET NOUN") ("o_qual" "" "PRON" "PRON PRON")
		     ("O_que" "ELIMINAR" "" "PRON PRON") ("o_que" "ELIMINAR" "" "PRON PRON")
		     ("on_line" "" "ADV" "X") ("ontem_de_manhã" "ELIMINAR" "" "ADV ADP NOUN")
		     ("os_quais" "" "PRON" "PRON PRON") ("Ou_melhor" "" "CCONJ" "CCONJ ADV")
		     ("Ou_seja" "" "CCONJ" "CCONJ VERB") ("ou_seja" "" "CCONJ" "CCONJ VERB")
		     ("outra_vez" "" "ADV" "PRON NOUN") ("outra_coisa" "ELIMINAR" "" "PRON NOUN")
		     ("para_a_direita" "ELIMINAR" "" "ADP DET NOUN")
		     ("Para_além" "Para_além_de" "ADP" "ADP ADV ADP")
		     ("para_além" "para_além_de" "ADP" "ADP ADV ADP")
		     ("Para_além_de" "" "ADP" "ADP ADV ADP")
		     ("para_além_de" "" "ADP" "ADP ADV ADP") ("para_caramba" "" "ADV" "ADP ADV")
		     ("para_casa" "ELIMINAR" "" "ADP NOUN") ("para_cima" "" "ADV" "ADP NOUN")
		     ("para_fora_de" "" "ADP" "ADP ADV ADP") ("Para_já" "" "ADV" "ADP ADV")
		     ("para_já" "" "ADV" "ADP ADV") ("para_o_lado" "" "ADV" "ADP DET NOUN")
		     ("para_onde" "" "ADV" "ADP PRON") ("para_que" "" "SCONJ" "ADP SCONJ")
		     ("para_sempre" "" "ADV" "ADP ADV")
		     ("Pela_primeira_vez" "" "ADV" "ADP DET NUM NOUN")
		     ("Pelo_contrário" "" "ADV" "ADP DET ADJ")
		     ("Pelo_menos" "" "ADV" "ADP DET ADJ") ("Perto_de" "" "ADP" "ADV ADP")
		     ("perto_de" "" "ADP" "ADV ADP") ("Pois_é" "" "INTJ" "CCONJ VERB")
		     ("pois_então" "" "CCONJ" "CCONJ ADV") ("pois_que" "" "CCONJ" "CCONJ CCONJ")
		     ("Por_acaso" "" "ADV" "ADP ADV") ("por_acaso" "" "ADV" "ADP ADV")
		     ("Por_agora" "" "ADV" "ADP ADV") ("por_aqui" "" "ADV" "ADP ADV")
		     ("por_assim_dizer" "" "ADV" "ADP ADV VERB") ("por_baixo" "" "ADV" "ADP ADV")
		     ("Por_causa_de" "" "ADP" "ADP NOUN ADP")
		     ("por_causa_de" "" "ADP" "ADP NOUN ADP") ("por_cento" "" "ADV" "ADP NUM")
		     ("por_cima" "" "ADV" "ADP NOUN") ("por_cima_de" "" "ADP" "ADP NOUN ADP")
		     ("por_completo" "" "ADV" "ADP ADJ") ("por_concurso" "ELIMINAR" "" "ADP NOUN")
		     ("Por_conseguinte" "" "ADV" "ADP ADV") ("por_conta" "" "ADV" "ADP NOUN")
		     ("por_conveniência" "" "ADV" "ADP NOUN")
		     ("por_detrás_de" "" "ADP" "ADP ADV ADP") ("Por_enquanto" "" "ADV" "ADP ADV")
		     ("por_enquanto" "" "ADV" "ADP ADV") ("Por_entre" "" "ADP" "ADP ADP")
		     ("por_entre" "" "ADP" "ADP ADP") ("por_escrito" "" "ADV" "ADP ADJ")
		     ("por_excelência" "" "ADV" "ADP NOUN") ("por_exclusão" "" "ADV" "ADP NOUN")
		     ("Por_exemplo" "" "ADV" "ADP NOUN") ("por_exemplo" "" "ADV" "ADP NOUN")
		     ("Por_fim" "" "ADV" "ADP NOUN") ("por_fim" "" "ADV" "ADP NOUN")
		     ("por_força_de" "" "ADP" "ADP NOUN ADP")
		     ("Por_iniciativa_de" "" "ADP" "ADP NOUN ADP")
		     ("por_iniciativa_de" "" "ADP" "ADP NOUN ADP")
		     ("por_isso" "por_isso_que" "SCONJ" "ADP PRON SCONJ")
		     ("por_mais_que" "" "SCONJ" "ADP ADV SCONJ")
		     ("por_mar" "ELIMINAR" "" "ADP NOUN") ("por_meio_de" "" "ADP" "ADP NOUN ADP")
		     ("por_ocasião_de" "" "ADP" "ADP NOUN ADP") ("por_onde" "" "SCONJ" "ADP PRON")
		     ("Por_ora" "" "ADV" "ADP ADV") ("Por_outro_lado" "" "ADV" "ADP PRON NOUN")
		     ("por_outro_lado" "" "ADV" "ADP PRON NOUN")
		     ("por_parte_de" "" "ADP" "ADP NOUN ADP") ("por_pessoa" "" "ADJ" "ADP NOUN")
		     ("por_pouco" "" "ADV" "ADP NOUN") ("Por_que" "" "SCONJ" "ADP SCONJ")
		     ("por_que" "" "SCONJ" "ADP SCONJ") ("por_quê" "" "SCONJ" "ADP NOUN")
		     ("Por_si" "" "ADV" "ADP PRON") ("por_si" "" "ADV" "ADP PRON")
		     ("Por_sua_vez" "" "ADV" "ADP PRON NOUN")
		     ("por_sua_vez" "" "ADV" "ADP PRON NOUN") ("por_trás" "" "ADV" "ADP ADV")
		     ("por_último" "" "ADV" "ADP ADJ") ("Por_um_lado" "" "ADV" "ADP DET NOUN")
		     ("por_um_lado" "" "ADV" "ADP DET NOUN")
		     ("por_unanimidade" "" "ADV" "ADP NOUN") ("Por_vezes" "" "ADV" "ADP NOUN")
		     ("por_vezes" "" "ADV" "ADP NOUN") ("por_via_de" "" "ADP" "ADP NOUN ADP")
		     ("por_volta_de" "" "ADP" "ADP NOUN ADP")
		     ("Pouco_a_pouco" "" "ADV" "NOUN ADP NOUN")
		     ("pouco_a_pouco" "" "ADV" "NOUN ADP NOUN") ("próximo_a" "" "ADP" "ADV ADP")
		     ("próximo_de" "" "ADP" "ADV ADP")
		     ("qualquer_que_fosse" "" "PRON" "PRON PRON VERB")
		     ("quando_de" "" "ADP" "PRON ADP") ("quando_muito" "" "ADV" "PRON ADV")
		     ("Quanto_a" "" "ADP" "PRON ADP") ("quanto_a" "" "ADP" "PRON ADP")
		     ("Quanto_mais" "" "SCONJ" "PRON ADV") ("quanto_mais" "" "" "PRON ADV")
		     ("que_património" "ELIMINAR" "" "PRON NOUN")
		     ("quer_dizer" "" "CCONJ" "VERB VERB") ("rumo_a" "" "ADP" "NOUN ADP")
		     ("se_bem_que" "" "SCONJ" "SCONJ ADV SCONJ")
		     ("se_calhar" "" "SCONJ" "SCONJ VERB") ("se_tanto" "" "ADV" "SCONJ ADV")
		     ("sem_conta" "" "ADJ" "ADP NOUN") ("sem_par" "" "ADJ" "ADP NOUN")
		     ("Sempre_que" "" "SCONJ" "ADV SCONJ") ("sempre_que" "" "SCONJ" "ADV SCONJ")
		     ("sendo_que" "" "SCONJ" "VERB SCONJ") ("sob_pena_de" "" "ADP" "ADP NOUN ADP")
		     ("Tal_como" "" "SCONJ" "PRON SCONJ") ("tal_como" "" "SCONJ" "PRON SCONJ")
		     ("Tanto_mais_quanto" "" "SCONJ" "PRON ADV PRON")
		     ("Tanto_mais_que" "" "SCONJ" "PRON ADV PRON")
		     ("tanto_mais_que" "" "SCONJ" "PRON ADV PRON")
		     ("tão_logo" "" "SCONJ" "ADV ADV") ("Toda_a" "ELIMINAR" "" "ADJ DET")
		     ("toda_a" "ELIMINAR" "" "ADJ DET")
		     ("Toda_vez_que" "" "SCONJ" "ADJ NOUN SCONJ")
		     ("Todas_as" "Todas_as_pessoas" "PRON" "ADJ DET NOUN")
		     ("todas_as" "todas_as_pessoas" "PRON" "ADJ DET NOUN")
		     ("Todo_mundo" "" "PRON" "ADJ NOUN") ("todo_o" "ELIMINAR" "" "ADJ DET")
		     ("Todos_os" "ELIMINAR" "" "ADJ DET") ("todos_os" "ELIMINAR" "" "ADJ DET")
		     ("todos_os_dias" "" "ADV" "ADJ DET NOUN")
		     ("Tudo_isso" "" "PRON" "PRON PRON")
		     ("tudo_isso" "" "PRON" "PRON PRON")
		     ("Tudo_isto" "" "PRON" "PRON PRON")
		     ("tudo_isto" "" "PRON" "PRON PRON")
		     ("Tudo_o_que" "ELIMINAR" "" "PRON PRON")
		     ("tudo_o_que" "ELIMINAR" "" "PRON PRON")
		     ("tudo_quanto" "" "PRON" "PRON PRON")
		     ("um_ao_outro" "" "PRON" "PRON ADP DET PRON")
		     ("um_pouco" "" "ADV" "DET NOUN")
		     ("um_tanto" "" "ADV" "DET NOUN") ("um_vez" "ELIMINAR" "" "DET NOUN")
		     ("uma_a_uma" "" "ADV" "NUM ADP NUM")
		     ("uma_centena_de" "" "ADP" "NUM NUM ADP")
		     ("Uma_vez" "" "ADV" "DET NOUN")
		     ("Uma_vez_mais" "" "ADV" "DET NOUN ADV")
		     ("uma_vez_mais" "" "ADV" "DET NOUN ADV")
		     ("uma_vez_por_todas" "de_ uma_vez_por_todas" "ADV" "ADP DET NOUN ADP PRON")
		     ("Uma_vez_que" "" "SCONJ" "DET NOUN SCONJ")
		     ("uma_vez_que" "" "SCONJ" "DET NOUN SCONJ")
		     ("uns_vez_que" "ELIMINAR" "" "DET NOUN SCONJ")
		     ("visto_que" "" "SCONJ" "ADJ SCONJ")))

(defun extract-ocurrences (sentences words)
  (remove-if-not (lambda (sentence)
		   (search words (mapcar #'token-lemma (sentence-tokens sentence)) :test #'string=))
		 sentences))

(defun run ()
  (let ((res (make-hash-table :test 'equal))
	(files (directory #p"../documents/*.conllu"))
	(patterns (split-sequence:split-sequence #\_
					       (remove-duplicates
						(mapcar (lambda (e) (string-downcase (car e)))table):test #'equal))))

    (loop for line in table
     do (let (words)
      	    (setq words (split-sequence:SPLIT-SEQUENCE #\_ (car line)))
	    (print "Searching:")
	    (print words)
	    (dolist (f (directory #p"../documents/*.conllu"))
	      (let ((extraction (extract-ocurrences (cl-conllu:read-conllu f) words)))
		(when extraction
		  (loop for sentence in extraction
		   do(if(gethash (sentence-id sentence) res)
			(print "existe");TODO - pega o elemento e adiciona o meta
			(setf (gethash (sentence-id sentence) res) sentence))))))))
  (let (mwe-sentences)
    (maphash #'(lambda (key val)(setq mwe-sentences (append (list val) mwe-sentences ))) res)
    (print "Found:")
    (print (list-length mwe-sentences))
    (write-conllu mwe-sentences "MWE.conll"))))
    
