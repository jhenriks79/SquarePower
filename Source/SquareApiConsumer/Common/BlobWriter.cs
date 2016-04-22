using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;
using System.IO;
using System.Threading.Tasks;

namespace SquareApiConsumer.Common
{
    public class BlobWriter
    {
        private readonly string _storageConnectionString;

        public BlobWriter(string storageConnectionString)
        {
            _storageConnectionString = storageConnectionString;
        }

        public CloudBlockBlob Read(string container, string blobName)
        {
            CloudBlobContainer blobContainer = GetBlobContainer(container);

            return blobContainer.GetBlockBlobReference(blobName);
        }

        public async Task WriteAsync(string existFilePath, string destContainer, string destFileName)
        {
            CloudBlockBlob blob = GetBlockBlobReference(destContainer, destFileName);

            using (var fileStream = File.OpenRead(existFilePath))
            {
                await blob.UploadFromStreamAsync(fileStream);
            }
        }

        private CloudBlobClient GetBlobClient()
        {
            CloudStorageAccount storageAccount = CloudStorageAccount.Parse(_storageConnectionString);

            return storageAccount.CreateCloudBlobClient();
        }

        private CloudBlobContainer GetBlobContainer(string container)
        {
            CloudBlobClient blobClient = GetBlobClient();
            CloudBlobContainer blobContainer = blobClient.GetContainerReference(container);

            if (blobContainer.CreateIfNotExists())
            {
                blobContainer.SetPermissions(new BlobContainerPermissions
                {
                    PublicAccess = BlobContainerPublicAccessType.Off
                });
            }

            return blobContainer;
        }

        private CloudBlockBlob GetBlockBlobReference(string container, string blobName)
        {
            CloudBlobContainer blobContainer = GetBlobContainer(container);

            return blobContainer.GetBlockBlobReference(blobName);
        }
    }
}