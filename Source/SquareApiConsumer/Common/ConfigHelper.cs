using System;
using System.Configuration;

namespace SquareApiConsumer.Common
{
    public static class ConfigHelper
    {
        public static string ApiKey
        {
            get { return GetConfigurationSettingAsString("ApiKey"); }
        }

        public static string StorageConnectionString
        {
            get { return GetConfigurationSettingAsString("StorageConnectionString"); }
        }

        public static string GetConfigSettingValue(string key)
        {
            return GetConfigurationSettingAsString(key);
        }

        private static bool GetConfigurationSettingAsBool(string key)
        {
            return bool.Parse(GetConfigurationSettingAsString(key));
        }

        private static byte[] GetConfigurationSettingAsBytes(string key)
        {
            return Convert.FromBase64String(GetConfigurationSettingAsString(key));
        }

        private static int GetConfigurationSettingAsInt(string key)
        {
            return int.Parse(GetConfigurationSettingAsString(key));
        }

        private static string GetConfigurationSettingAsString(string key)
        {
            return ConfigurationManager.AppSettings[key];
        }
    }
}