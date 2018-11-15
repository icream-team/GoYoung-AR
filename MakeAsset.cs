using UnityEngine;
using System.Collections;
using UnityEditor;

public class MakeAsset
{
    [MenuItem("Assets/Create/Save/makingAsset")]
    public static void CreateAsset()
    {
        SaveDataList AssetSave = ScriptableObject.CreateInstance<SaveDataList>();
        AssetDatabase.CreateAsset(AssetSave, "Assets/Save/savedData.asset");
        AssetDatabase.SaveAssets();
    }
}


    