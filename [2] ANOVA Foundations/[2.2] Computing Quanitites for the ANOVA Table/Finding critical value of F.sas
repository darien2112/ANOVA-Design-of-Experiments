data Fvalue;                                                                                                                               
                   q=finv(0.95, 3, 20);                                                                                                                   
                   put q=;                                                                                                                           
                run;
                proc print data=work.Fvalue;
                 run;