FROM centos:7

RUN     yum -y install \
        bash-completion \
        dmidecode \
        smartmontools \
        iproute \
        net-tools \
        wget \
        perl \
        sudo \
        perl-IPC-Run \
        freeipmi \
        OpenIPMI \
        ipmitool \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && mkdir -p /megacli \
    && curl -sSL -o /tmp/megacli.rpm https://srkdev.com/megacli/MegaCli-8.07.14-1.noarch.rpm \
    && rpm -ivh /tmp/*.rpm \
    && rm /tmp/*.rpm \
    && ln -sf /opt/MegaRAID/MegaCli/MegaCli64 /usr/bin/MegaCli \
    && echo '/megacli/bench.sh' >> ~/.bashrc \
    && echo 'echo -----------------------------------------------------------------------' >> ~/.bashrc \
    && echo 'MegaCli -ShowSummary -a0' >> ~/.bashrc \
    && echo 'echo -----------------------------------------------------------------------' >> ~/.bashrc \
    && echo 'echo RAID STATUS:' >> ~/.bashrc \
    && echo '/megacli/check_raid.pl' >> ~/.bashrc \
    && echo 'echo Short Status:' >> ~/.bashrc \
    && echo 'MegaCli -PDList -aALL | awk -f /megacli/aw.awk' >> ~/.bashrc \
    && echo 'echo -----------------------------------------------------------------------' >> ~/.bashrc \
    && echo 'echo S.M.A.R.T status:' >> ~/.bashrc \
    && echo '/megacli/smart_drives.sh' >> ~/.bashrc \
    && echo 'echo -----------------------------------------------------------------------' >> ~/.bashrc \
    && echo 'echo Power Status:' >> ~/.bashrc \
    && echo '/megacli/check_ipmi_sensor.pl -T 'Power_Supply'' >> ~/.bashrc


COPY resources/scripts /megacli
COPY resources/scripts2 /megacli/scripts
WORKDIR "/megacli"
RUN chmod a+x *.sh *.pl \
&& chmod -R a+x /megacli/scripts

CMD ["bash", "-l"]
