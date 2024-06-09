
# Creación e implementación de contratos

Pasos  a seguir para poder subir los contratos a [ThirdWeb](https://thirdweb.com/)


## Despliegue


```bash
  npx thirdweb@latest create --contract
```

Seleccionamos Hardhat

Ponemos un nombre cualquiera al contrato y no elegimos ninguna plantilla

Cogemos los archivos de este GitHub y los arrastramos dentro de nuestro directorio




## Comandos

```bash
  npm install dotenv
  npm install @openzeppelin/contracts
```
    
# Pasos

Una vez hecho todo debemos hacer lo siguiente :

1. Crear el archivo .env y poner nuestra PRIVATE_KEY de nuestra cartera

2. Obtener API de [Alchemy](https://dashboard.alchemy.com/apps), en nuestro caso usaremos Sepolia

3. En el archivo **hardhat.config.js** escribir una nueva entrada dentro de **networks** con el siguiente formato:
*sepolia: {
      url: '' ,
      accounts: process.env.PRIVATE_KEY
    }*

4. En el archivo **hardhat.config.js** escribir la url de la API obtenida

5. Usar el siguente comando y seleccionar los contratos que queremos subir :
```bash
  npm run deploy
```
