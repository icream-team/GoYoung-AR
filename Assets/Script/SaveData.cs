using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

[CreateAssetMenu(fileName = "Data", menuName = "Save/makeAsset", order = 1)]
[System.Serializable]
public class SaveData :ScriptableObject
{
    public System.DateTime Time; //시간
    public int Status;   //스테이터스
    public int Love;//애정도
    //고영종류
}
