using MaasOne.Base;
using MaasOne.Finance.YahooFinance;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace SymbolSpider
{
    class Program
    {
        static void Main(string[] args)
        {
            AlphabeticIDIndexDownload dl1 = new AlphabeticIDIndexDownload();
            dl1.Settings.TopIndex = null;
            Response<AlphabeticIDIndexResult> resp1 = dl1.Download();

            var writeStream = new StreamWriter("symbols.txt");
            writeStream.WriteLine("Id|Isin|Name|Exchange|Type|Industry");

            foreach (var alphabeticalIndex in resp1.Result.Items)
            {
                AlphabeticalTopIndex topIndex = (AlphabeticalTopIndex)alphabeticalIndex;
                dl1.Settings.TopIndex = topIndex;
                Response<AlphabeticIDIndexResult> resp2 = dl1.Download();

                foreach (var index in resp2.Result.Items)
                {
                    IDSearchDownload dl2 = new IDSearchDownload();
                    Response<IDSearchResult> resp3 = dl2.Download(index);


                    int i = 0;
                    foreach (var item in resp3.Result.Items)
                    {
                        writeStream.WriteLine(item.ID + "|" + item.ISIN + "|" + item.Name + "|" + item.Exchange + "|" + item.Type + "|" + item.Industry);
                    }

                }
            }
        }
    }
}
