$TTL    86400
@               IN      SOA     ns.l1-3.ephec-ti.be. admin.l1-3.ephec-ti.be. (
                                2023041701      ; serial number
                                14400              ; refresh
                                3600            ; retry
                                604800          ; expire
                                86400           ; minimum TTL
                                )
                IN      NS      ns.l1-3.ephec-ti.be.
                IN      A       54.37.15.74
                IN      MX  10  mail.l1-3.ephec-ti.be.
                IN      TXT     "v=spf1 mx -all"
ns              IN      A       54.37.15.74
www             IN      A       54.37.15.74
blog            IN      A       54.37.15.74
_acme-challenge IN      TXT     "mY337FXz0PILDYw762WT4fiYK3Cx4HgPfIMcpO2omX8"
mail            IN      A       54.37.15.74
mail._domainkey IN      TXT     ( "v=DKIM1; h=sha256; k=rsa; "
          "p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvX0lBU6f6p6L/m5C/pEYgpWlrnRdnu24ilw5YGkVNjgnHxRDqXB+qDxxO/JJTRhWgHNZyiEpF9nryJIX726XFmUm/gXzhUg5C52nLI+vtg0D/g7kqzzVpELzpJVdMJZlKmNkjzU/6Axk0WSrYtFiy9QPVhJzLuPXjZ+yvoty9UIr+acGJfiKQb39sB7WEHAzM/BGkdc0kdibl3"
          "/3ft3fgOUXConSSvltCkngpWdBHxqBX3L85Ix7H54vjtiMAWgv0k4M25ZjLHSOHJyL3TkzBs4u/Y0O1KUrnZoxXc8pjeCM4MfZdkrwAshHxaiUIgaN3EvIf2IOuoWkeEii54LClwIDAQAB" )  ; ----- DKIM key mail for l1-3.ephec-ti.be
_dmarc.l1-3.ephec-ti.be. IN TXT "v=DMARC1; p=quarantine; rua=mailto:sa.lambert@students.ephec.be,mailto:j.pollart@students.ephec.be; ruf=mailto:sa.lambert@students.ephec.be,mailto:j.pollart@students.ephec.be; sp=quarantine; fo=1; ri=86400"