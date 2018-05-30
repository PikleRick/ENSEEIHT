function TG = T_Gabor(signal,nb_echantillons_par_mesure)
    TG = [];
    debut = 1;
    fin = nb_echantillons_par_mesure;
    
    while fin < length(signal)
        TG = [TG fft(signal(debut:fin))];
        debut = debut + nb_echantillons_par_mesure;
        fin = fin + nb_echantillons_par_mesure;
    end
    
end