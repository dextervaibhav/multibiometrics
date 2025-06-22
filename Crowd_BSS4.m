function [cdist] = Crowd_BSS4(cdist,fitnesscat,tmpfront)
       
        for m=1:5
            fitnesstmpfront =[];
            tmpfront_map_fitnesstmpfront = cell(1,size(tmpfront,2));

            for ii=1:size(tmpfront,2)
                fitnesstmpfront(end+1) = fitnesscat{tmpfront(1,ii)}(1,m);
                tmpfront_map_fitnesstmpfront{tmpfront(1,ii)} = fitnesscat{tmpfront(1,ii)}(1,m);
            end

            ufitnesstmpfront = unique(fitnesstmpfront);
            ufitnesstmpfront = sort(ufitnesstmpfront,'descend');


            sortedtmpfront =[];

            for ii=1:size(ufitnesstmpfront,2)
                for j=1:size(tmpfront,2)
                    if tmpfront_map_fitnesstmpfront{tmpfront(1,j)} == ufitnesstmpfront(1,ii);
                        sortedtmpfront(end+1) = tmpfront(1,j);
                    end
                end
            end

            cdist{sortedtmpfront(1,1)} = 10000000;
            cdist{sortedtmpfront(1,size(sortedtmpfront,2))}=10000000;

            mxfitness = tmpfront_map_fitnesstmpfront{sortedtmpfront(1,1)};
            mnfitness = tmpfront_map_fitnesstmpfront{sortedtmpfront(1,size(sortedtmpfront,2))};


            for ii=2:size(sortedtmpfront,2)-1
                cdist{sortedtmpfront(1,ii)} = cdist{sortedtmpfront(1,ii)}+abs((tmpfront_map_fitnesstmpfront{sortedtmpfront(1,ii+1)}-tmpfront_map_fitnesstmpfront{sortedtmpfront(1,ii-1)})/(mxfitness-mnfitness));
                if isnan(cdist{sortedtmpfront(1,ii)})
                    cdist{sortedtmpfront(1,ii)} = 10000000;
                end
            end

        end
        

end
