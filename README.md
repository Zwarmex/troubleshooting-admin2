# Introduction

N'ayant pas rencontré de problème particulier lors de la réalisation des tps, nous avons décidé, suite à une discution avec Monsieur Dubruille, de "créer" une situation de troubleshooting. Pour ce faire, Julien a modifié un endroit dans le code afin de créer un problème. Samuel quant à lui, s'est amusé à chercher où était l'erreur. La situation a débuté lorsqu'il s'est rendu compte que le site web était accessible en local, mais pas de l'extérieur.

# Etapes troubleshooting

1. Regarder si on a accès au site web depuis l'extérieur. (via browser ou `wget 54.37.15.74`)

![pb-web](https://github.com/Zwarmex/admin-II/assets/101929037/3142013d-733b-4b9c-ad2c-32438283a34c)
![pb-page-cli](https://github.com/Zwarmex/admin-II/assets/101929037/aadea73f-3e57-40e6-873a-17ff996282a9)

Ici, on voit bien qu'on a pas accès à la page web depuis l'extérieur.

2. Regarder si on a accès au site web depuis l'intérieur. (`wget localhost`)

![pb-cli-localhost](https://github.com/Zwarmex/admin-II/assets/101929037/31e8786e-0db0-4964-bee2-707f4925cd53)

Ici on remarque que cela fonctionne depuis l'intérieur.

3. Regarder les port ouvert sur la machine `netstat -nltpu`

<img width="1439" alt="pb-netstat" src="https://github.com/Zwarmex/admin-II/assets/101929037/46faf078-6ae2-4aa0-a133-1075a51333cb">

Le port 80 est bien ouvert.

4. Regarder les ports ouvert sur docker `docker ps`

![pb-dp](https://github.com/Zwarmex/admin-II/assets/101929037/c5a1113f-5e11-4b88-a9b1-b65ad1d1c1cf)

On voit qu'il y a bien la redirection de port 80:80

5. Regarder les ports visibles depuis l'extérieur `nmap -sC -sV $IP`

![pb-nmap](https://github.com/Zwarmex/admin-II/assets/101929037/d07deff1-f9bb-48bc-abf0-4c487a5c907a)

Ici, on remarque qu'on ne voit pas le port 80 depuis l'extérieur de la machine.

6. Regarder les logs `docker logs $CONTAINER_NAME`

Il n'y a pas de logs car aucune connection entrante.

7. Regarder le traffic via une capture Wireshark

![pb-wireshark](https://github.com/Zwarmex/admin-II/assets/101929037/5f39cccf-5f26-4218-bc0d-6066e156e135)

On voit que la connection est refusée. Après toute cette démarche, on pense directement à une chose, le parefeu à l'air de nous bloqué l'accès depuis l'extérieur.

# Proposition de solution

Il faudrait modifier les règles du parefeu afin d'autoriser les connection sur le port 80 depuis l'extérieur aussi. Pour ce faire il faut supprimer les anciennes règles iptables concernant le port 80 (web) pour rajouter la nouvelle : `sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT` OU il faut désactiver le parefeu.

# Preuve de la résolution du problème

1 et 2. Regarder si on a accès au site web depuis l'extérieur et depuis l'intérieur. (via browser ou `wget 54.37.15.74` OU `wget localhost`)

<img width="1440" alt="pb-resolu-page-cli" src="https://github.com/Zwarmex/admin-II/assets/101929037/47d59699-16d7-44b5-a391-69788aa758fa">
<img width="1440" alt="pb-resolu-page-web" src="https://github.com/Zwarmex/admin-II/assets/101929037/fcca5a13-1c08-46aa-8ad5-4fd0154ea4fe">

On remarque ici, qu'on voit bien apparaitre la page internet depuis l'extérieur. ET le site est aussi accessible depuis l'intérieur.

3. Regarder les ports visibles depuis l'extérieur `nmap -sC -sV $IP`

![pb-resolu-nmap](https://github.com/Zwarmex/admin-II/assets/101929037/5dd100b7-b973-40c9-87ec-e4f404aa82d7)

Contrairement à avant, on voit bien que le port 80 est visible depuis l'extérieur de la machine.

4. Regarder les logs `docker logs $CONTAINER_NAME`

![pb-resolu-logs](https://github.com/Zwarmex/admin-II/assets/101929037/a81399d9-0ecc-469c-90a8-4f9969d825c5)

Dans les logs, on voit bien qu'il y a eu une connection sur le container WEB.

5. Regarder le traffic via une capture Wireshark

![pb-resolu-wireshark](https://github.com/Zwarmex/admin-II/assets/101929037/1bd7c4f8-d939-4fef-b6ec-407fde12aade)

On voit sur la capture wireshark qu'il y a une connection et du traffic entre la machine cliente et le serveur web.
On remarque donc, que une fois le changement effectué sur le parefeu, nous avons bien accès à la page web depuis l'intérieur comme de l'extérieur.
