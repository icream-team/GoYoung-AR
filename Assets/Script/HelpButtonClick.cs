using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class HelpButtonClick : MonoBehaviour {
    private GameObject help;

    public void Onclick()
    {
        help.SetActive(true);
    }
    void Start()
    {
        help = GameObject.FindWithTag("Help");
    }

}
