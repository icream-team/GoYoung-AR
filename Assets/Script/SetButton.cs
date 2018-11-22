using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetButton : MonoBehaviour
{
    private GameObject set;

    public void Onclick()
    {
        set.SetActive(true);
    }
    void Start()
    {
        set = GameObject.FindWithTag("Set");
    }

}
