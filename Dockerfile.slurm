FROM registry.fedoraproject.org/fedora:40 AS base

RUN dnf install --assumeyes slurm slurm-slurmd slurm-slurmctld && \
    dnf clean all

RUN /usr/sbin/mungekey && \
    chown munge:munge /etc/munge/munge.key

ENTRYPOINT /usr/sbin/init
# --------- --------- --------- --------- --------- --------- --------- --------- --------- ---------
FROM base AS slurm-control

ADD slurm-slurm.conf  /etc/slurm/slurm.conf

RUN systemctl enable munge
RUN systemctl enable slurmctld
# --------- --------- --------- --------- --------- --------- --------- --------- --------- ---------
FROM base AS slurm-runner

ADD slurm-sysconfig /etc/sysconfig/slurmd

RUN systemctl enable munge
RUN systemctl enable slurmd
