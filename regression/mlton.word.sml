functor F (S: sig
		 type word

		 val trials: word list
		 val ~ : word -> word
		 val fromInt: int -> word
		 val max: word
		 val rol: word * Word.word -> word
		 val ror: word * Word.word -> word
		 val toString: word -> string
		 val wordSize: int
		 val zero: word
	      end) =
   struct
      open S

      val rots = List.tabulate (wordSize + 1, Word.fromInt)

      fun p w = print (concat [toString w, "\n"])
	 
      (* Test Algebraic simplifications. *)
      val _ = List.app (fn w => p (rol (w, 0w0))) trials
      val _ = List.app (fn w => p (ror (w, 0w0))) trials
      val _ = List.app (fn w => p (rol (w, Word.fromInt wordSize))) trials
      val _ = List.app (fn w => p (ror (w, Word.fromInt wordSize))) trials
      val _ = List.app (fn w => p (rol (zero, w))) [0w1, 0w2, 0w3]
      val _ = List.app (fn w => p (ror (zero, w))) [0w1, 0w2, 0w3]
      val _ = List.app (fn w => p (rol (max, w))) [0w1, 0w2, 0w3]
      val _ = List.app (fn w => p (ror (max, w))) [0w1, 0w2, 0w3]

      val _ =
	 List.app
	 (fn oper =>
	  List.app
	  (fn w => List.app (fn w' => p (oper (w, w'))) rots)
	  trials)
	 [rol, ror]
   end

structure Z = F (open Word MLton.Word
		 val zero: word = 0w0
		 val max: word = 0wxFFFFFFFF
		 val trials: word list =
		    [0w0, 0w1, 0wxF, 0wx7F7F7F7F, 0wxFFFFFFFF])
structure Z = F (open Word8 MLton.Word8
		 val zero: word = 0w0
		 val max: word = 0wxFF
		 val trials: word list =
		    [0w0, 0w1, 0wxF, 0wx7F, 0wxFF])
