# Olympe

## Technologies :
- Ruby on rails 4.1.4
- MySQL
- Bootstrap
- OpenPGP

## Installation
```sh
$ git clone [git-repo-url] olympe
$ cd olympe
$ bundle install
```

Creer une base de données 'olympe' sur le serveur avec un compte associé
* importer la base de donnée grace au fichier olympe/database/olympe.sql

Configurer l'application pour communiquer avec notre nouvelle base de donnée
* modifier le fichier olympe/config/database.yml avec les informations de connexion

Mise à jour du fichier olympe/db/schema.rb :
```sh
$ bin/rake db:migrate
```

## Configuration
* Créer un compte sur le site une fois le serveur démarré
    * Modifier dans la table 'olympe'.'users' pour le nouvel utilisateur crée les champs 'is_activ' et 'is_admin' à '1'

* Se connecter au site avec le compte nouvellement crée
* Dans l'onglet 'MON COMPTE' en haut à droite, cliquer sur le bouton 'Générer la clé' et sauvegarder la modification
* Dans l'onglet 'ADMIN' définir une nouvelle passphrase puis cliquer sur le bouton 'Générer'
