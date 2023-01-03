FROM rapporteket/dev:nightly

LABEL maintainer "Are Edvardsen <are.edvardsen@helse-nord.no>"

ARG GH_PAT
ENV GITHUB_PAT=${GH_PAT}

# add registry dev config and R pkg dependencies
COPY --chown=rstudio:rstudio db.yml /home/rstudio/rap_config/
RUN cat /home/rstudio/rap_config/db.yml >> /home/rstudio/rap_config/dbConfig.yml \
    && rm /home/rstudio/rap_config/db.yml \
    && R -e "install.packages(c('digest', \
                                'DT', \
                                'kableExtra',\
                                'knitr', \
                                'lifecycle', \
                                'lintr', \
                                'lubridate',\
                                'plyr',\
                                'shiny',\
                                'shinyalert',\
                                'xtable',\
                                'zoo'))" \
    && R -e "remotes::install_github(c('Rapporteket/rapbase', 'Rapporteket/rapFigurer', 'Rapporteket/raplog'))"
