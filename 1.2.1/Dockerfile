###=========================================================================
### File: Dockerfile.in
###
### Author(s): Enrique Fernandez <efcasado@gmail.com>
###=========================================================================
FROM       centos:6
MAINTAINER Enrique Fernandez <efcasado@gmail.com>

# Install Basho's repo
RUN yum install -y                                               \
        http://yum.basho.com/gpg/basho-release-6-1.noarch.rpm && \
    yum clean all

# Install Riak
RUN yum install -y          \
        riak-1.2.1 && \
    yum clean all

# Install supervisord
RUN yum install -y      \
        epel-release && \
    yum install -y      \
        supervisor   && \
    yum clean all

COPY ./usr/etc/ /usr/etc

# Entry point
COPY ./docker-entrypoint.sh docker-entrypoint.sh
ENTRYPOINT [ "./docker-entrypoint.sh" ]
