FROM debian:buster
RUN apt update && apt install -y \
    vsftpd
ARG FTP_PASS
ARG FTP_USER
RUN mkdir -p /home/ftp/${FTP_USER}
RUN useradd -m -d /home/ftp/${FTP_USER} -c "ftp user" -p ${FTP_PASS} $FTP_USER && \
    echo Created ${FTP_USER} user && \
    echo ${FTP_USER} >> /etc/vsftpd.chroot_list
# RUN mkdir -p /etc/vsftpd && chown -R ${FTP_USER}:${FTP_USER} /etc/vsftpd
COPY --chown=root:root conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN mkdir -p /var/share/empty && chmod -R 644 /var/share/empty
EXPOSE 21
CMD [ "vsftpd", "/etc/vsftpd/vsftpd.conf" ]